import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/home/view/screen/home_screen.dart';
import 'package:health_reminder/notification_helper.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await NotificationHelper().initializeNotification();
  runApp(const ProviderScope(child: PillPallApp()));
}

class PillPallApp extends StatelessWidget {
  const PillPallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const HomeScreen());
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:timezone/data/latest.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

// // ---------------------- Notification Helper ----------------------
// class NotificationHelper {
//   final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

//   Future<void> initializeNotification() async {
//     const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const initSettings = InitializationSettings(
//       android: androidInit,
//       iOS: DarwinInitializationSettings(),
//     );
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//   }

//   /// ask Android 13+ for exact-alarm permission
//   Future<void> requestExactAlarmPermission() async {
//     final androidImpl =
//         flutterLocalNotificationsPlugin
//             .resolvePlatformSpecificImplementation<
//               AndroidFlutterLocalNotificationsPlugin
//             >();
//     await androidImpl?.requestExactAlarmsPermission();
//   }

//   Future<void> scheduleTestNotification() async {
//     const androidDetails = AndroidNotificationDetails(
//       'pill_channel_id',
//       'Pill Reminders',
//       channelDescription: 'Reminders for scheduled pills',
//       importance: Importance.max,
//       priority: Priority.high,
//     );

//     const details = NotificationDetails(android: androidDetails);

//     // 🔔 show notification 5 seconds later
//     final scheduledTime = tz.TZDateTime.now(
//       tz.local,
//     ).add(const Duration(seconds: 5));

//     await flutterLocalNotificationsPlugin.zonedSchedule(
//       0,
//       '💊 Time to take your pill!',
//       'Vitamin C — Test Notification',
//       scheduledTime,
//       details,
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents: DateTimeComponents.dateAndTime,
//     );
//   }
// }
// // -----------------------------------------------------------------

// Future<void> requestAllNotificationPermissions(
//   FlutterLocalNotificationsPlugin plugin,
// ) async {
//   // Ask normal notification permission
//   await Permission.notification.request();

//   // Ask exact alarm permission for Android 12+
//   final androidImpl =
//       plugin
//           .resolvePlatformSpecificImplementation<
//             AndroidFlutterLocalNotificationsPlugin
//           >();
//   await androidImpl?.requestExactAlarmsPermission();
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   tz.initializeTimeZones();

//   final helper = NotificationHelper();
//   await helper.initializeNotification();
//   await requestAllNotificationPermissions(
//     helper.flutterLocalNotificationsPlugin,
//   );

//   runApp(MyApp(notificationHelper: helper));
// }

// class MyApp extends StatelessWidget {
//   final NotificationHelper notificationHelper;
//   const MyApp({super.key, required this.notificationHelper});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(title: const Text('Notification Test 💊')),
//         body: Center(
//           child: ElevatedButton(
//             onPressed: () async {
//               await notificationHelper.scheduleTestNotification();
//             },
//             child: const Text('Test Notification'),
//           ),
//         ),
//       ),
//     );
//   }
// }
