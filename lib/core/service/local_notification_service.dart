import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:product_details/core/utils/constants.dart';
import 'package:product_details/core/views/app_toast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/remote/api_client.dart';
import '../utils/connectivity_checker.dart';

/// Top-level function to handle background messages.
Future<void> handleBackgroundMessaging(RemoteMessage message) async {
  // You may perform additional background processing here.
}

class FirebaseAPI {
  final _firebaseMessaging = FirebaseMessaging.instance;

  // Android Notification Channel
  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is for important notifications.',
    importance: Importance.high,
  );

  // Local Notifications Plugin
  final _localNotifications = FlutterLocalNotificationsPlugin();

  /// Handle incoming message when app is in foreground or background.
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print(
        "Message received in app: ${message.notification?.title}, ${message.notification?.body}");
    // Additional handling can be done here, like navigation.
  }

  /// Initialize local notifications.
  Future<void> initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');

    const settings = InitializationSettings(android: android, iOS: iOS);

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        // Process the payload when notification is clicked
        final message = RemoteMessage.fromMap(jsonDecode(response.payload!));
        handleMessage(message);
      },
    );

    // Create Android notification channel
    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  /// Initialize push notifications.
  Future<void> initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle message when app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // App is opened from background state
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    // Background message handler
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessaging);

    // Foreground messages
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      // Show a local notification for foreground messages
      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher',
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  /// Main initialization for Firebase Messaging and local notifications.
  Future<void> initNotifications() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();
    await prefs.setString(FCMToken, fCMToken ?? "");

    await initPushNotifications();
    await initLocalNotifications();
  }

  Future<void> sendFirebaseMessage(String message) async {
    try {
      bool isConnected = await checkInternetConnection();
      if (!isConnected) {
         showFailureToast(noInternetConnection);
      } else {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        final fcmToken = await prefs.getString(FCMToken);
        ApiClient client = ApiClient(
            baseUrl:
                'https://fcm.googleapis.com/v1/projects/seller-push-notification/',
            dio: dio.Dio());
        final jsonCredentials = await rootBundle
            .loadString('assets/seller-push-notification-4242b3206cc1.json');
        final credentials =
            ServiceAccountCredentials.fromJson(jsonDecode(jsonCredentials));

        const scopes = <String>[
          'https://www.googleapis.com/auth/firebase.messaging'
        ];
        final authClient = await clientViaServiceAccount(credentials, scopes);
        final accessToken = authClient.credentials.accessToken.data;

        final response = await client.post(
          'messages:send',
          options:
              dio.Options(headers: {'Authorization': 'Bearer $accessToken'}),
          data: {
            "message": {
              "token": fcmToken,
              "notification": {"body": message, "title": "Seller"}
            }
          },
        );
      }
    } catch (e) {
      showFailureToast('Message Not Sent');
    }
  }
}
