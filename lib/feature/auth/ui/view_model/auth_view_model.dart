import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/auth_repository_remote.dart';
import 'package:health_reminder/feature/auth/login_request_model.dart';
import 'package:health_reminder/feature/auth/login_response_model.dart';

class AuthViewModel extends AsyncNotifier<LoginResponseModel?> {
  @override
  FutureOr<LoginResponseModel?> build() {
    return null;
  }

  Future<void> login(LoginRequestModel model) async {
    state = AsyncLoading();
    try {
      final response = await ref.read(authProvider).login(model: model);
      state = AsyncData(response);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}

final authViewModelProvider =
    AsyncNotifierProvider<AuthViewModel, LoginResponseModel?>(
      () => AuthViewModel(),
    );
