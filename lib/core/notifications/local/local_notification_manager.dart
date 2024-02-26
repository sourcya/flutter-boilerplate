import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

const AndroidNotificationChannel _androidNotificationChannel =
    AndroidNotificationChannel(
  'push_notifications_channel',
  'Notifications',
  description: 'This channel is used for push notifications.',
  importance: Importance.max,
);

class LocalNotificationManager {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> createNotificationChannel() async {
    return _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);
  }

  Future<bool?> requestPermission() async {
    return _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  void showForegroundNotification(RemoteMessage message) {
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
}
