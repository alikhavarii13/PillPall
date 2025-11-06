// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/auth_repository.dart';
import 'package:health_reminder/feature/auth/login_request_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService implements AuthRepository {
  final SupabaseClient _supabaseClient = Supabase.instance.client;

  @override
  Future<bool> get isAuthenticated async {
    final session = _supabaseClient.auth.currentSession;
    return session?.accessToken != null;
  }

  @override
  Future<AuthResponse> login({required LoginRequestModel model}) {
    return _supabaseClient.auth.signInWithPassword(
      email: model.email,
      password: model.password,
    );
  }

  @override
  Future<void> logout() {
    return _supabaseClient.auth.signOut();
  }
}

final authServiceProvider = Provider<AuthService>((ref) => AuthService());
final authStateProvider = FutureProvider<bool>((ref) async {
  final authService = ref.watch(authServiceProvider);
  return await authService.isAuthenticated;
});
