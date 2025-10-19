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

//TODO debug this
// // ignore_for_file: avoid_print
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_timezone/flutter_timezone.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// /// CHANGE: Added singleton pattern for better app-wide access
// class NotificationHelper {
//   // CHANGE: Singleton implementation - ensures only one instance exists
//   static final NotificationHelper _instance = NotificationHelper._internal();
//   factory NotificationHelper() => _instance;
//   NotificationHelper._internal();

//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   bool _isInitialized = false;
//   bool get initialized => _isInitialized;

//   /// CHANGE: Added onNotificationTap callback parameter to handle notification taps
//   Future<void> initializeNotification({
//     Function(NotificationResponse)? onNotificationTap,
//   }) async {
//     if (_isInitialized) return;
//     await requestAndroidPermissions();

//     tz.initializeTimeZones();

//     // CHANGE: Fixed timezone handling for flutter_timezone 2.x
//     // The package returns different types based on version
//     String currentTimeZone = 'Asia/Tehran'; // Default fallback
//     try {
//       final dynamic timezoneData = await FlutterTimezone.getLocalTimezone();
//       // CHANGE: Handle both String and TimezoneInfo types
//       if (timezoneData is String) {
//         currentTimeZone = timezoneData;
//       } else {
//         // For TimezoneInfo object, try to access the identifier property
//         currentTimeZone =
//             timezoneData.identifier ?? timezoneData.name ?? 'Asia/Tehran';
//       }
//       print('Retrieved timezone: $currentTimeZone');
//     } catch (e) {
//       print('Error getting timezone: $e');
//       currentTimeZone = 'Asia/Tehran'; // fallback
//     }

//     const Map<String, String> windowsToIana = {
//       'Iran Standard Time': 'Asia/Tehran',
//       // add more mappings here as needed
//     };
//     final String fixedTimeZone =
//         windowsToIana[currentTimeZone] ?? currentTimeZone;

//     try {
//       tz.setLocalLocation(tz.getLocation(fixedTimeZone));
//       print('Timezone set to $fixedTimeZone');
//     } catch (e) {
//       print('Error setting timezone $fixedTimeZone: $e');
//       // CHANGE: More robust fallback with explicit try-catch
//       try {
//         tz.setLocalLocation(tz.getLocation('Asia/Tehran'));
//         print('Fallback: Timezone set to Asia/Tehran');
//       } catch (fallbackError) {
//         print('Critical: Could not set any timezone: $fallbackError');
//       }
//     }

//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(
//       android: androidInit,
//       iOS: DarwinInitializationSettings(),
//     );

//     // CHANGE: Added onDidReceiveNotificationResponse callback to handle notification taps
//     await flutterLocalNotificationsPlugin.initialize(
//       initSettings,
//       onDidReceiveNotificationResponse: (NotificationResponse response) {
//         print('Notification tapped: ${response.payload}');
//         // CHANGE: Call custom callback if provided
//         onNotificationTap?.call(response);
//       },
//     );

//     // CHANGE: Removed unnecessary camera permission check
//     // var status = await Permission.camera.status;
//     // if (status.isDenied) {}

//     _isInitialized = true;
//   }

//   Future<void> requestAndroidPermissions() async {
//     final notificationStatus = await Permission.notification.request();
//     if (notificationStatus.isGranted) {
//       print('Notification permission granted.');
//     } else {
//       print('Notification permission denied.');
//     }

//     final exactAlarmStatus = await Permission.scheduleExactAlarm.status;
//     if (!exactAlarmStatus.isGranted) {
//       final newStatus = await Permission.scheduleExactAlarm.request();
//       if (newStatus.isGranted) {
//         print('Exact alarm permission granted.');
//       } else {
//         print('Exact alarm permission denied.');
//       }
//     }

//     // CHANGE: Added battery optimization check for reliable notifications
//     final ignoreBatteryStatus =
//         await Permission.ignoreBatteryOptimizations.status;
//     if (!ignoreBatteryStatus.isGranted) {
//       print('Battery optimization is enabled - this may prevent notifications');
//       final newStatus = await Permission.ignoreBatteryOptimizations.request();
//       if (newStatus.isGranted) {
//         print(
//           'Battery optimization disabled - notifications should work better',
//         );
//       } else {
//         print(
//           'Battery optimization still enabled - notifications may not work reliably',
//         );
//       }
//     }
//   }

//   NotificationDetails notificationDetails() {
//     return const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'daily_channel_id',
//         'Daily notification',
//         channelDescription: 'daily something',
//         importance: Importance.max,
//         priority: Priority.high,
//         // CHANGE: Added these settings for better notification delivery
//         playSound: true,
//         enableVibration: true,
//         enableLights: true,
//         showWhen: true,
//         visibility: NotificationVisibility.public,
//       ),
//       iOS: DarwinNotificationDetails(),
//     );
//   }

//   Future<void> showNotifications({
//     int id = 0,
//     String? title,
//     String? body,
//   }) async {
//     await flutterLocalNotificationsPlugin.show(
//       id,
//       title,
//       body,
//       notificationDetails(),
//     );
//   }

//   /// CHANGE: Added try-catch error handling for better error management
//   Future<void> scheduleNotification({
//     int id = 1,
//     String? title,
//     String? body,
//     required int hour,
//     required int minute,
//   }) async {
//     try {
//       final now = tz.TZDateTime.now(tz.local);
//       var scheduledDate = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month,
//         now.day,
//         hour,
//         minute,
//       );

//       if (scheduledDate.isBefore(now)) {
//         scheduledDate = scheduledDate.add(const Duration(days: 1));
//       }

//       print("Notification scheduled for $scheduledDate");
//     } catch (e) {
//       // CHANGE: Added error logging and rethrow
//       print('Error scheduling notification: $e');
//       rethrow;
//     }
//   }

//   /// CHANGE: New method - Schedule daily recurring notification
//   Future<void> scheduleDailyNotification({
//     int id = 1,
//     String? title,
//     String? body,
//     required int hour,
//     required int minute,
//   }) async {
//     try {
//       final now = tz.TZDateTime.now(tz.local);
//       var scheduledDate = tz.TZDateTime(
//         tz.local,
//         now.year,
//         now.month,
//         now.day,
//         hour,
//         minute,
//       );

//       if (scheduledDate.isBefore(now)) {
//         scheduledDate = scheduledDate.add(const Duration(days: 1));
//       }

//       // CHANGE: Added matchDateTimeComponents to make it repeat daily
//       await flutterLocalNotificationsPlugin.zonedSchedule(
//         id,
//         title,
//         body,
//         scheduledDate,
//         notificationDetails(),
//         androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

//         matchDateTimeComponents:
//             DateTimeComponents.time, // Repeats daily at same time
//       );
//       print("Daily notification scheduled for $hour:$minute");
//     } catch (e) {
//       print('Error scheduling daily notification: $e');
//       rethrow;
//     }
//   }

//   /// CHANGE: New method - Cancel a specific notification by ID
//   Future<void> cancelNotification(int id) async {
//     try {
//       await flutterLocalNotificationsPlugin.cancel(id);
//       print('Notification with id $id cancelled');
//     } catch (e) {
//       print('Error cancelling notification: $e');
//       rethrow;
//     }
//   }

//   Future<void> cancelNotifications() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }

//   /// CHANGE: New method - Get list of all pending notifications
//   Future<List<PendingNotificationRequest>> getPendingNotifications() async {
//     try {
//       return await flutterLocalNotificationsPlugin
//           .pendingNotificationRequests();
//     } catch (e) {
//       print('Error getting pending notifications: $e');
//       return [];
//     }
//   }

//   /// CHANGE: New method - Check if a specific notification is scheduled
//   Future<bool> isNotificationScheduled(int id) async {
//     try {
//       final pendingNotifications = await getPendingNotifications();
//       return pendingNotifications.any((notification) => notification.id == id);
//     } catch (e) {
//       print('Error checking if notification is scheduled: $e');
//       return false;
//     }
//   }

//   /// CHANGE: New method - Print all pending notifications for debugging
//   Future<void> printPendingNotifications() async {
//     final pending = await getPendingNotifications();
//     print('=== Pending Notifications (${pending.length}) ===');
//     for (var notification in pending) {
//       print(
//         'ID: ${notification.id}, Title: ${notification.title}, Body: ${notification.body}',
//       );
//     }
//   }
// }
