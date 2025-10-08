import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;
  bool get initialized => _isInitialized;

  //TODO this part is edited by AI read it carefully
  Future<void> initializeNotification() async {
    if (_isInitialized) return;

    // 1️⃣ Initialize timezone
    tz.initializeTimeZones();
    final timezone = await FlutterTimezone.getLocalTimezone();
    var currentTimeZone = timezone.localizedName!.name;

    const windowsToIana = {'Iran Standard Time': 'Asia/Tehran'};
    currentTimeZone = windowsToIana[currentTimeZone] ?? currentTimeZone;
    tz.setLocalLocation(tz.getLocation(currentTimeZone));

    // 2️⃣ Initialize plugin
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initSettings = InitializationSettings(
      android: androidInit,
      iOS: DarwinInitializationSettings(),
    );

    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // 3️⃣ Request general notification permission (Android 13+ / iOS)
    final androidImpl =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >();
    await androidImpl?.requestNotificationsPermission();

    final iosImpl =
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >();
    await iosImpl?.requestPermissions(alert: true, badge: true, sound: true);

    // 4️⃣ Request "Exact Alarms" permission (Android 12+)
    final exactGranted =
        await androidImpl?.canScheduleExactNotifications() ?? false;
    if (!exactGranted) {
      await androidImpl?.requestExactAlarmsPermission();
    }

    _isInitialized = true;
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
