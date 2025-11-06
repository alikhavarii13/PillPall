import 'package:health_reminder/feature/auth/login_request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<AuthResponse> login({required LoginRequestModel model});

  Future<void> logout();
}
