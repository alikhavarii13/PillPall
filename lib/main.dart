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
