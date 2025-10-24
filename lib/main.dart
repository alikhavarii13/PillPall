import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/core/shared/app_theme.dart';
import 'package:health_reminder/feature/home/ui/view/screen/home_screen.dart';
import 'package:health_reminder/notification_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationHelper().initializeNotification();
  runApp(const ProviderScope(child: PillPallApp()));
}

class PillPallApp extends StatelessWidget {
  const PillPallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightTheme(), home: const HomeScreen());
  }
}
