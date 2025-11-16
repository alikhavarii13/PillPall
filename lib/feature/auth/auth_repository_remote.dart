// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/auth_repository.dart';
import 'package:health_reminder/feature/auth/data/model/auth_tokens.dart';
import 'package:health_reminder/feature/auth/data/token_notifier.dart';
import 'package:health_reminder/feature/auth/login_request_model.dart';
import 'package:health_reminder/feature/auth/login_response_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService implements AuthRepository {
  final Ref _ref;
  final Dio _dio;

  AuthService(this._ref, this._dio);

  @override
  Future<LoginResponseModel> login({required LoginRequestModel model}) async {
    final response = await _dio.post(
      "/auth/v1/token?grant_type=password",
      data: {"email": model.email, "password": model.password},
    );
    final loginResponse = LoginResponseModel.fromJson(response.data);
    _ref
        .read(tokenProvider.notifier)
        .saveTokens(
          AuthTokens(
            accessToken: loginResponse.accessToken,
            refreshToken: loginResponse.refreshToken,
          ),
        );
    return loginResponse;
  }

  @override
  Future<bool> get isAuthenticated => throw UnimplementedError();

  @override
  Future<void> logout() {
    throw UnimplementedError();
  }
}

// final authServiceProvider = Provider<AuthService>((ref) => AuthService());
// final authStateProvider = FutureProvider<bool>((ref) async {
//   final authService = ref.watch(authServiceProvider);
//   return await authService.isAuthenticated;
// });
