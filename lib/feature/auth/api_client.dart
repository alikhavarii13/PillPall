import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.example.com'));
}

class TokenNotifier extends StateNotifier<AuthTokens?> {
  final String _accessTokenKey = "access_token";
  final String _refreshTokenKey = "refresh_token";
  TokenNotifier() : super(null);

  // TODO different  between
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

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? 'default_url'),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['apikey'] = dotenv.env['API_KEY'];
        options.headers['Authorization'] = ref.read(tokenProvider);
        handler.next(options);
      },
      onError: (error, handler) {
        // TODO this code is not right add supabase refreshtoken firstt
        if (error.response!.statusCode == 401) {
          ref.read(tokenProvider.notifier);
          error.requestOptions.headers['Authorization'] = ref.read(
            tokenProvider.notifier,
          );
          dio.fetch(error.requestOptions);
          handler.resolve(error.response!);
        }
      },
    ),
  );
  return dio;
});
