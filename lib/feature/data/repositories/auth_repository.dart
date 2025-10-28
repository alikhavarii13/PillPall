abstract class AuthRepository {
  Future<bool> get isAuthenticated;

  Future<void> login({required String email, required String password});

  Future<void> logout();
}
