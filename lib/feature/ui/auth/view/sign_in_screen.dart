import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/feature/ui/home/view/widget/custom_text_field_widget.dart';
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
                        final AuthResponse res = await Supabase
                            .instance
                            .client
                            .auth
                            .signInWithPassword(
                              email: emailController.text,
                              password: passwordController.text,
                            );
                        print('user is:${res.user}');
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

Future<void> signInWithEmail() async {}
