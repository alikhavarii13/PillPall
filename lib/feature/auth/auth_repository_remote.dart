// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/core/dio/dio_provider.dart';
import 'package:health_reminder/feature/auth/data/repositories/auth_repository.dart';
import 'package:health_reminder/feature/auth/data/services/api/model/auth_tokens.dart';
import 'package:health_reminder/feature/auth/data/token_notifier.dart';
import 'package:health_reminder/feature/auth/data/services/api/model/login_request_model.dart';
import 'package:health_reminder/feature/auth/data/services/api/model/login_response_model.dart';

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
    print(loginResponse);
    return loginResponse;
  }

  @override
  Future<bool> get isAuthenticated async {
    await _ref.read(tokenProvider.notifier).getToken();
    final tokens = _ref.read(tokenProvider);
    return tokens != null;
  }

  @override
  Future<void> logout() async {
    await _dio.post("/auth/v1/logout");
    _ref.read(tokenProvider.notifier).clearToken();
  }
}

final authProvider = Provider<AuthService>((ref) {
  final dio = ref.watch(dioProvider);
  return AuthService(ref, dio);
});

final authStateProvider = FutureProvider<bool>((ref) {
  return ref.watch(authProvider).isAuthenticated;
});
