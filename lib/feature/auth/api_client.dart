import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.example.com'));
}

class TokenNotifier extends StateNotifier<String?> {
  final String _tokenKey = "token";

  TokenNotifier() : super(null);

  // TODO different  between
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // final SharedPreferences pref;

  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    state = pref.getString(_tokenKey);
    return state;
  }

  Future<bool> saveString(String? token) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    state = token;
    return pref.setString(_tokenKey, state!);
  }

  Future<void> logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(_tokenKey);
    state = null;
  }
}

final tokenProvider = StateNotifierProvider<TokenNotifier, String?>(
  (ref) => TokenNotifier(),
);

final dioProvider = Provider<Dio>((ref) {
  final token = ref.watch(tokenProvider);
  final dio = Dio(
    BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? 'default_url'),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['Authorization'] = token;
        handler.next(options);
      },
    ),
  );
  return dio;
});
