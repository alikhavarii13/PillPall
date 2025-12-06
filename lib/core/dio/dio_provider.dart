import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:health_reminder/feature/auth/data/services/api/model/auth_tokens.dart';
import 'package:health_reminder/feature/auth/data/services/local/token_notifier.dart';

final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(baseUrl: dotenv.env['BASE_URL'] ?? 'default_url'),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['apikey'] = dotenv.env['API_KEY'];
        final tokens = ref.read(tokenProvider);
        if (options.uri.path == "/auth/v1/token" &&
            options.uri.queryParameters["grant_type"] == "password") {
          options.headers["Authorization"] = null;
        }

        if (tokens != null) {
          options.headers['Authorization'] = "Bearer ${tokens.accessToken}";
        }
        handler.next(options);
      },
      onError: (error, handler) async {
        final tokens = ref.read(tokenProvider);

        if (error.response!.statusCode == 401) {
          final refreshResponse = await dio.post(
            "/auth/v1/token?grant_type=refresh_token",
            data: {"refresh_token": tokens!.refreshToken},
            options: Options(
              headers: {
                "apikey": dotenv.env["API_KEY"],
                "Content-Type": "application/json",
              },
            ),
          );
          if (refreshResponse.statusCode != 200) {
            await ref.read(tokenProvider.notifier).clearToken();
            return handler.next(error);
          }

          final newAccessToken = refreshResponse.data["access_token"];
          final newRefreshToken = refreshResponse.data["refresh_token"];
          final newTokens = AuthTokens(
            accessToken: newAccessToken,
            refreshToken: newRefreshToken,
          );
          await ref.read(tokenProvider.notifier).saveTokens(newTokens);
          error.requestOptions.headers["Authorization"] =
              "Bearer $newAccessToken";
          final retryResponse = await dio.fetch(error.requestOptions);
          return handler.resolve(retryResponse);
        }
        return handler.next(error);
      },
    ),
  );
  return dio;
});
