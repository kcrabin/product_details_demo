import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  static final NotificationServices _instance = NotificationServices._();
  static NotificationServices get instance => _instance;

  NotificationServices._() {
    initializeNotification();
  }

  late NotificationDetails notificationDetails;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    DarwinInitializationSettings initializationSettingsIOS =
    const DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings("launch_background"),
        iOS: initializationSettingsIOS);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  showProgressNotification(
      {required int id, required String title, required int progress}) async {
    AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails("channelId", "channelName",
        importance: Importance.high,
        priority: Priority.high,
        showProgress: true,
        onlyAlertOnce: true,
        maxProgress: 50,
        autoCancel: true,
        progress: progress);
    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      "",
      notificationDetails,
    );
  }

  showNotification(
      {required int id, required String title, required String body}) async {
    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails(
      "distress_channel",
      "Distress",
      importance: Importance.high,
      priority: Priority.high,
      showProgress: true,
    );
    DarwinNotificationDetails iosDetails = const DarwinNotificationDetails(
      presentSound: true,
      presentBadge: true,
      presentAlert: true,
    );
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: iosDetails);

    flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
    );
  }
}
