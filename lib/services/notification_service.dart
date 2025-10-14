import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotification;
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  NotificationService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotification,
  })  : _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance,
        _localNotification =
            localNotification ?? FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    // Request for notification permission
    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("notification permission granted");
    }

    // initialize local notification
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotification.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // FCM Token retrieve and save in your server
    final token = await _firebaseMessaging.getToken();
    print("fcm token $token");

    // Listen to foreground message
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);
    // Listen to background message
    FirebaseMessaging.onMessageOpenedApp.listen(_handleBackgroundMessage);
    // Check if app was opened from notification
    final initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleNotificationNavigation(initialMessage.data);
    }
  }

  Future<void> _handleForegroundMessage(RemoteMessage message) async {
    final title = message.notification?.title ?? '';
    final body = message.notification?.body ?? '';
    final payload = message.data['data'];

    await _showLocalNotification(title: title, body: body, payload: payload);
  }

  Future<void> _showLocalNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    final androidDetails = AndroidNotificationDetails(
      'my-channel-id',
      'my-channel-name',
      importance: Importance.high,
      priority: Priority.high,
      showWhen: true,
      icon: '@mipmap/ic_launcher',
    );

    final iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotification.show(
      12,
      title,
      body,
      details,
      payload: payload,
    );
  }

  Future<void> _onNotificationTapped(NotificationResponse response) async {
    _handleNotificationNavigation(response.data);
  }

  Future<void> _handleBackgroundMessage(RemoteMessage remoteMessage) async {
    _handleNotificationNavigation(remoteMessage.data);
  }

  Future<void> _handleNotificationNavigation(Map<String, dynamic> data) async {
    final message = data['message'];
    if (message != null) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          '/dashboard', (route) => false,
          arguments: {'message': message});
    }
  }
}
