import 'package:health_reminder/feature/auth/data/services/api/model/login_request_model.dart';
import 'package:health_reminder/feature/auth/data/services/api/model/login_response_model.dart';

abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<LoginResponseModel> login({required LoginRequestModel model});

  Future<void> logout();
}
