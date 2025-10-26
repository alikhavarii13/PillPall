import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/ui/auth/view/sign_in_screen.dart';
import 'package:health_reminder/notification_helper.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: "assets/.env");
  } catch (e) {
    throw Exception('Error loading .env file: $e');
  }
  await Supabase.initialize(
    url: dotenv.env['BASE_URL'] ?? 'default_url',
    anonKey: dotenv.env['API_KEY'] ?? 'default_key',
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
