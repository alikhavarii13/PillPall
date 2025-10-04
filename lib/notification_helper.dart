import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_reminder/home/data/pills_model.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initializeNotification() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
  }

  Future<void> schedulePillNotification(PillsModel pill) async {
    final androidDetails = const AndroidNotificationDetails(
      'pill_channel_id',
      'Pill Reminders',
      channelDescription: 'Reminders for scheduled pills',
      importance: Importance.max,
      priority: Priority.high,
    );

    final details = NotificationDetails(android: androidDetails);

    final tzTime = tz.TZDateTime.from(pill.reminderTime, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      pill.id ?? DateTime.now().millisecondsSinceEpoch ~/ 1000,
      'Time to take your pill 💊',
      pill.pillName,
      tzTime,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }
}
