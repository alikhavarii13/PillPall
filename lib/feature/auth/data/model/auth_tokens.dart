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
