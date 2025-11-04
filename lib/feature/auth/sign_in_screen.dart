import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/core/shared/widget/custom_text_field_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign In')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Form(
              child: Column(
                children: [
                  CustomTextfieldWidget(
                    title: 'Email',
                    controller: emailController,
                  ),
                  Gap(16),
                  CustomTextfieldWidget(
                    title: 'Password',
                    controller: passwordController,
                  ),
                  //Spacer(),
                  Gap(16),
                  Container(
                    height: 48,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(color: Colors.black, offset: Offset(6, 6)),
                      ],
                    ),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff4A90E2),
                        shape: BeveledRectangleBorder(),
                      ),

                      onPressed: () async {
                        AuthService().signInWithEmailAndPassword(
                          emailController.text,
                          passwordController.text,
                        );
                      },
                      child: Text('Sign In'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthService {
  Future<bool> get isAuthenticated async {
    return _supabaseClient.auth.currentSession?.accessToken != null;
  }

  final SupabaseClient _supabaseClient = Supabase.instance.client;
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print(_supabaseClient.auth.currentUser);
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final authStateProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.isAuthenticated;
});
