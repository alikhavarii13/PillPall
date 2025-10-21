// ignore_for_file: avoid_print

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get initialized => _isInitialized;

  Future<void> initializeNotification() async {
    if (_isInitialized) return;

    await requestAndroidPermissions();

    tz.initializeTimeZones();

    final timezone = await FlutterTimezone.getLocalTimezone();
    var currentTimeZone = timezone.localizedName!.name;

    const windowsToIana = {'Iran Standard Time': 'Asia/Tehran'};
    currentTimeZone = windowsToIana[currentTimeZone] ?? currentTimeZone;
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);
    var status = await Permission.camera.status;
    if (status.isDenied) {}

    _isInitialized = true;
  }

  Future<void> requestAndroidPermissions() async {
    final notificationStatus = await Permission.notification.request();
    if (notificationStatus.isGranted) {
      print('Notification permission granted.');
    } else {
      print('Notification permission denied.');
    }

    final exactAlarmStatus = await Permission.scheduleExactAlarm.status;
    if (!exactAlarmStatus.isGranted) {
      final newStatus = await Permission.scheduleExactAlarm.request();
      if (newStatus.isGranted) {
        print('Exact alarm permission granted.');
      } else {
        print('Exact alarm permission denied.');
      }
    }
  }

  NotificationDetails notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_channel_id',
        'Daily notification',
        channelDescription: 'daily something',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future<void> showNotifications({
    int id = 0,
    String? title,
    String? body,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails(),
    );
  }

  Future<void> scheduleNotification({
    int id = 1,
    String? title,
    String? body,
    required int hour,
    required int minute,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );

    print("Notification scheduled for $scheduledDate");
  }

  Future<void> cancelNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
