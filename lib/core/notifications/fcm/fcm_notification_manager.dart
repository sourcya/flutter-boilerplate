import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../local/local_notification_manager.dart';
import '../push_notification_manager.dart';
import 'firebase_options.dart';

abstract class FcmNotificationManager {
  StreamSubscription<RemoteMessage>? _foregroundMessageSub;
  StreamSubscription<RemoteMessage>? _openingMessageSub;
  StreamSubscription<String>? _tokenSub;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final LocalNotificationManager _localNotificationManager =
      LocalNotificationManager();

  /// Handles What should happen when user ope the app from notification
  Future<void> handleOpeningMessage(RemoteMessage message);

  /// Handle Saving token and syncing it with the server
  Future<void> handleSavingToken(String token);

  // ignore: unreachable_from_main
  /// Request notification permission;
  /// On Ios :
  ///
  /// provisional permission system allows for notification permission to be instantly granted without displaying a dialog to your user.
  /// When a notification is displayed on the device, the user will be presented with several actions prompting to keep receiving notifications quietly,
  /// enable full notification permission or turn them off: Only available on Ios.
  Future<NotificationSettings> requestPermission() {
    _localNotificationManager.requestPermission();
    return _firebaseMessaging.requestPermission(
      provisional: true,
    );
  }

  // ignore: unreachable_from_main
  Future<void> setupForegroundNotification() async {
    //IOS
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );

    //Android
    _localNotificationManager.createNotificationChannel();
  }

  Future<void> setupFcm() async {
    await setupForegroundNotification();
    await requestPermission();
  }

  /// Initialize the fcm notifications.
  // ignore: unreachable_from_main
  Future<void> init() async {
    setupFcm();
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  // ignore: unreachable_from_main
  Future<void> setupToken() async {
    // Get the token each time the application loads
    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      // Save the initial token to the database
      await handleSavingToken(token);
    }

    _tokenSub?.cancel();
    // Any time the token refreshes, store this in the database too.
    _tokenSub =
        FirebaseMessaging.instance.onTokenRefresh.listen(handleSavingToken);
  }

  // ignore: unreachable_from_main
  Future<void> listenToForegroundMessage() async {
    _foregroundMessageSub?.cancel();
    _foregroundMessageSub =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      showForegroundNotification(message);
    });
  }

  void showForegroundNotification(RemoteMessage message) {
    return _localNotificationManager.showForegroundNotification(message);
  }

  // ignore: unreachable_from_main
  Future<void> setupInteractedMessage() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleOpeningMessage(initialMessage);
    }

    _openingMessageSub?.cancel();
    _openingMessageSub =
        FirebaseMessaging.onMessageOpenedApp.listen(handleOpeningMessage);
  }

  // ignore: unreachable_from_main
  Future<void> subscribeToTopic(String topic) {
    return _firebaseMessaging.subscribeToTopic(topic);
  }

  // ignore: unreachable_from_main
  Future<void> unsubscribeFromTopic(String topic) async {
    return _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  // ignore: unreachable_from_main
  void dispose() {
    _foregroundMessageSub?.cancel();
    _openingMessageSub?.cancel();
    _tokenSub?.cancel();
  }
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PushNotificationManager.instance.setupFcm();
  print(
    "FcmNotificationManager : Handling a background message: ${message.messageId}",
  );
}
