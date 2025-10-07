import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:health_reminder/feature/home/data/pills_model.dart';
// import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final bool _isInitialized = false;
  bool get initialized => _isInitialized;

  Future<void> initializeNotification() async {
    if (initialized) return;
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        "daily_channel_id",
        "Daily notification",
        channelDescription: "daily something",
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotifications({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }
  // Future<void> schedulePillNotification(PillsModel pill) async {
  //   final androidDetails = const AndroidNotificationDetails(
  //     'pill_channel_id',
  //     'Pill Reminders',
  //     channelDescription: 'Reminders for scheduled pills',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   );

  //   final details = NotificationDetails(android: androidDetails);

  //   final tzTime = tz.TZDateTime.from(pill.reminderTime, tz.local);

  //   await flutterLocalNotificationsPlugin.zonedSchedule(
  //     pill.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
  //     'Time to take your pill 💊',
  //     pill.pillName,
  //     tzTime,
  //     details,
  //     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
  //     matchDateTimeComponents: DateTimeComponents.dateAndTime,
  //   );
  // }

  // Future<void> cancelNotification(int id) async {
  //   await flutterLocalNotificationsPlugin.cancel(id);
  // }
}
