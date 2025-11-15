import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/data/token_notifier.dart';

class AuthTokens {
  AuthTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  AuthTokens copyWith({String? newAccessToken, String? newRefreshToken}) {
    return AuthTokens(
      accessToken: newAccessToken ?? accessToken,
      refreshToken: newRefreshToken ?? refreshToken,
    );
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, AuthTokens?>(
  (ref) => TokenNotifier(),
);
