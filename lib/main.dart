import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/data/repositories/auth_repository_remote.dart';
import 'package:health_reminder/feature/auth/ui/view/sign_in_screen.dart';
import 'package:health_reminder/feature/home/ui/view/screen/home_screen.dart';
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

class PillPallApp extends ConsumerWidget {
  const PillPallApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);

    return MaterialApp(
      // TODO why token is not saving??
      home: authState.when(
        data: (isAuthenticated) {
          return isAuthenticated ? const HomeScreen() : const SignInScreen();
        },
        loading:
            () => const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
        error: (err, _) => Scaffold(body: Center(child: Text('Error: $err'))),
      ),
    );
  }
}
