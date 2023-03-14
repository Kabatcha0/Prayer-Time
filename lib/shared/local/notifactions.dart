import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class Notifications {
  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  // اعدادات المبدئبة لتهيئة الاشعارات
  static Future init() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var android = const AndroidInitializationSettings("@mipmap/ic_launcher");
    var initSetting = InitializationSettings(android: android);
    // لانشاء التايم زون
    tz.initializeTimeZones();

    await flutterLocalNotificationsPlugin!.initialize(
      initSetting,
    );
  }

// لظهور الاشعارت
  static Future showNotification(
      {required String nameOfPrayer,
      required String body,
      required int seconds}) async {
    await flutterLocalNotificationsPlugin!.zonedSchedule(
        0,
        nameOfPrayer,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
        const NotificationDetails(
            android: AndroidNotificationDetails("channelId", "channelName",
                importance: Importance.max, priority: Priority.high)),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true);
  }

// لو مش عايز اشعارات
  static Future cancelNotification() async {
    await flutterLocalNotificationsPlugin!.cancelAll();
  }
}
