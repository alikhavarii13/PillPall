abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<dynamic> login({required String email, required String password});
}
