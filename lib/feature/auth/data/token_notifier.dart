import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/data/model/auth_tokens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenNotifier extends StateNotifier<AuthTokens?> {
  final String _accessTokenKey = "access_token";
  final String _refreshTokenKey = "refresh_token";
  TokenNotifier() : super(null);

  // SharedPreferences pref = await SharedPreferences.getInstance();
  // final SharedPreferences pref;

  Future<void> saveTokens(AuthTokens tokens) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    state = tokens;
    pref.setString(_accessTokenKey, state!.accessToken);
    pref.setString(_refreshTokenKey, state!.refreshToken);
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_accessTokenKey);
    pref.remove(_refreshTokenKey);
    state = null;
  }

  Future<AuthTokens?> getToken() async {
    final pref = await SharedPreferences.getInstance();

    final access = pref.getString(_accessTokenKey);
    final refresh = pref.getString(_refreshTokenKey);

    if (access != null && refresh != null) {
      state = AuthTokens(accessToken: access, refreshToken: refresh);
    } else {
      state = null;
    }

    return state;
  }
}
