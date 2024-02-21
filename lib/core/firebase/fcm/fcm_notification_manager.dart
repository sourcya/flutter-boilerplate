import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_boilerplate/core/firebase/firebase_options.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FcmNotificationManager.instance.setupFcm();
  // FcmNotificationManager.instance._showNotification(message);

  print(
      "FcmNotificationManager : Handling a background message: ${message.messageId}");
}

const AndroidNotificationChannel _androidNotificationChannel =
    AndroidNotificationChannel(
  'high_importance_channel',
  'Notifications',
  description: 'This channel is used for important notifications.',
  importance: Importance.max,
);

// ignore: unreachable_from_main
class FcmNotificationManager {
  static FcmNotificationManager get instance => FcmNotificationManager();

  static final FcmNotificationManager _instance =
      FcmNotificationManager._internal();

  // ignore: unreachable_from_main
  factory FcmNotificationManager() {
    return _instance;
  }

  FcmNotificationManager._internal();

  StreamSubscription<RemoteMessage>? _foregroundMessageSub;
  StreamSubscription<RemoteMessage>? _openingMessageSub;
  StreamSubscription<String>? _tokenSub;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> setupFcm() async {
    await setupForegroundNotification();
    await requestPermission();
  }

  // ignore: unreachable_from_main
  Future<void> init() async {
    await setupFcm();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  // ignore: unreachable_from_main
  Future<void> setupToken() async {
    // Get the token each time the application loads
    final token = await FirebaseMessaging.instance.getToken();

    if (token != null) {
      // Save the initial token to the database
      await _handleSavingToken(token);
    }

    _tokenSub?.cancel();
    // Any time the token refreshes, store this in the database too.
    _tokenSub =
        FirebaseMessaging.instance.onTokenRefresh.listen(_handleSavingToken);
  }

  // ignore: unreachable_from_main
  Future<void> listenToForegroundMessage() async {
    _foregroundMessageSub?.cancel();
    _foregroundMessageSub =
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _showNotification(message);
    });
  }

  // ignore: unreachable_from_main
  Future<void> setupInteractedMessage() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleOpeningMessage(initialMessage);
    }

    _openingMessageSub?.cancel();
    _openingMessageSub =
        FirebaseMessaging.onMessageOpenedApp.listen(_handleOpeningMessage);
  }

  //Navigate To destination
  void _handleOpeningMessage(RemoteMessage message) {
    print('FcmNotificationManager : _handleOpeningMessage :${message.data}');
  }

  Future<void> _handleSavingToken(String token) async {
    print('FcmNotificationManager : SAVING TOKEN :$token');
  }

  void _showNotification(RemoteMessage message) {
    final notification = message.notification;
    final android = message.notification?.android;
    print(
        'FcmNotificationManager : _showNotification ${notification.hashCode}  :${notification?.title} ${notification?.body}');

    // If `onMessage` is triggered with a notification, construct our own
    // local notification to show to users using the created channel.
    if (notification != null && android != null) {
      _flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidNotificationChannel.id,
            _androidNotificationChannel.name,
            channelDescription: _androidNotificationChannel.description,
            importance: _androidNotificationChannel.importance,
            priority: Priority.high,
            icon: 'app_icon',
          ),
        ),
      );
    }
  }

  // ignore: unreachable_from_main
  Future<NotificationSettings> requestPermission() {
    return _firebaseMessaging.requestPermission(
      ///This type of permission system allows for notification permission to be instantly granted without displaying a dialog to your user.
      ///When a notification is displayed on the device, the user will be presented with several actions prompting to keep receiving notifications quietly,
      /// enable full notification permission or turn them off: Only available on Ios.
      provisional: false,
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
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  // ignore: unreachable_from_main
  void dispose() {
    _foregroundMessageSub?.cancel();
    _openingMessageSub?.cancel();
    _tokenSub?.cancel();
  }
}
