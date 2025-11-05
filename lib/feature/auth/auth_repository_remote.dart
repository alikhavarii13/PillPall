import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  Future<AuthResponse> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    print(_supabaseClient.auth.currentUser);
    return await _supabaseClient.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<bool> get isAuthenticated async {
    return _supabaseClient.auth.currentSession?.accessToken != null;
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final authStateProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.isAuthenticated;
});
