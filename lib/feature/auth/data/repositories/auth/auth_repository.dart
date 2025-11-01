import 'package:health_reminder/feature/auth/data/service/api/model/login_request/login_request_model.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<void> login({required LoginRequestModel model});

  Future<void> logout();
}
