import 'dart:async';
import 'dart:math';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_noitification.dart';
import 'package:society_app/pages/gatekeeper_dashboard/guard_notification/guard_notification.dart';
import 'package:society_app/pages/user_dashboard/modules/notification.dart';
import 'package:society_app/view_model/user_session.dart';

// Top-level function for background notification tap
@pragma('vm:entry-point')
void onBackgroundNotificationTap(NotificationResponse notificationResponse) {
  print('Notification tapped: ${notificationResponse.payload}');
}

class NotificationServices with ChangeNotifier {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final List<RemoteMessage> _notificationList = [];

  List<RemoteMessage> get notifications => _notificationList;

  void addNotificationToList(RemoteMessage message) {
    _notificationList.add(message);
    notifyListeners();
  }

  void initLocalNotification(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iosInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleNotificationClick(context, response.payload);
      },
      onDidReceiveBackgroundNotificationResponse: onBackgroundNotificationTap,
    );
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User denied permission');
    }
  }

  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((message) {
      print('Received notification while app is in foreground.');

      // Log message details
      print('Message data: ${message.data}');
      print('Notification title: ${message.notification?.title}');
      print('Notification body: ${message.notification?.body}');

      initLocalNotification(context, message);
      addNotificationToList(message);
      showNotification(message);
    });

    initPushNotification(context);
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
      Random.secure().nextInt(1000).toString(),
      'High Importance Notifications',
      importance: Importance.max,
    );
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id.toString(),
      channel.name.toString(),
      importance: Importance.high,
      priority: Priority.high,
      ticker: 'ticker',
      icon: '@mipmap/ic_launcher',
    );

    DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    _flutterLocalNotificationsPlugin.show(
        0,
        message.notification!.title.toString(),
        message.notification!.body.toString(),
        notificationDetails,
        payload: message.data['route']); // Pass route or identifier in payload
  }

  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    });
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      print('Token refreshed: $event');
    });
  }

  void handleNotificationClick(BuildContext context, String? payload) {
    final type = GlobalData().role;
    print('Notification clicked with payload: $payload');
    if (type == 'security_guard') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GuardNoitificationIconPage()));
    } else if (type == 'society_member') {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => NotificationPageUser()));
    }
  }

  void initPushNotification(BuildContext context) async {
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        handleNotificationClick(context, message.data['route']);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      handleNotificationClick(context, message.data['route']);
    });
  }
}
