import 'package:health_reminder/feature/auth/login_request_model.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<void> login({required LoginRequestModel model});

  Future<void> logout();
}
