import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  var mNotificationManager = FlutterLocalNotificationsPlugin();
  var androidNotificationDetails = const AndroidNotificationDetails(
      'test', 'test channel',
      autoCancel: true,
      ongoing: false,
      largeIcon: DrawableResourceAndroidBitmap('app_icon'));

  var iOSNotificationDetails = const DarwinNotificationDetails();
  void initialize(onNotificationTap) {
    var androidInitSettings = const AndroidInitializationSettings('app_icon');
    var iOSInitSetting = const DarwinInitializationSettings();
    var macOSInitSetting = const DarwinInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: androidInitSettings,
        iOS: iOSInitSetting,
        macOS: macOSInitSetting);

    mNotificationManager.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onNotificationTap,
    );

    mNotificationManager
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .requestNotificationsPermission();
  }

  void sendNotification({
    int id = 100,
    required String title,
    required String body,
  }) {
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);
    mNotificationManager.show(id, title, body, notificationDetails);
  }

  void scheduleNotification({
    int id = 200,
    required String title,
    required String body,
  }) {
    var notificationDetails = NotificationDetails(
        android: androidNotificationDetails,
        iOS: iOSNotificationDetails,
        macOS: iOSNotificationDetails);

    mNotificationManager.periodicallyShow(
        id, title, body, RepeatInterval.everyMinute, notificationDetails);
  }

  cancelNotification({int id = 100}) {
    mNotificationManager.cancel(id);
  }
}
