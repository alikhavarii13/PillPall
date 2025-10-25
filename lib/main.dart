import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/core/shared/app_theme.dart';
import 'package:health_reminder/feature/ui/auth/view/sign_in_screen.dart';
import 'package:health_reminder/feature/ui/home/view/screen/home_screen.dart';
import 'package:health_reminder/notification_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://fjhqdhcmmofhgcldfxgb.supabase.co',
    anonKey: 'sb_publishable_NmBk2sYi81tAXqoJ3ckKqA_ekeMapHy',
  );
  await NotificationHelper().initializeNotification();
  runApp(const ProviderScope(child: PillPallApp()));
}

class PillPallApp extends StatelessWidget {
  const PillPallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: const SignInScreen());
  }
}
