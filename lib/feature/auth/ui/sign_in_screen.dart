// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:health_reminder/core/shared/widget/custom_text_field_widget.dart';
import 'package:health_reminder/feature/auth/login_request_model.dart';
import 'package:health_reminder/feature/auth/ui/view_model/auth_view_model.dart';
import 'package:health_reminder/feature/home/ui/view/screen/home_screen.dart';

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
    final authState = ref.watch(authViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listen(authViewModelProvider, (previous, next) {
        if (next.hasValue) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        }
        if (next.hasError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("error")));
        }
      });
    });

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
                        await ref
                            .read(authViewModelProvider.notifier)
                            .login(
                              LoginRequestModel(
                                email: emailController.text,
                                password: passwordController.text,
                              ),
                            );
                      },
                      child:
                          authState.isLoading
                              ? CircularProgressIndicator()
                              : Text('Sign In'),
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
