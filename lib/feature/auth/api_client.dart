import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio})
    : _dio = dio ?? Dio(BaseOptions(baseUrl: 'https://api.example.com'));
}

class SaveToken {
  final String _tokenKey = "token";
  //TODO different  between
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // final SharedPreferences pref;

  Future<String?> getToken() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    return pref.getString(_tokenKey);
  }
}
// class AuthApiClient {
//   AuthApiClient({String? host, int? port, HttpClient Function()? clientFactory})
//     : _host = host ?? 'localhost',
//       _port = port ?? 8080,
//       _clientFactory = clientFactory ?? HttpClient.new;

//   final String _host;
//   final int _port;
//   final HttpClient Function() _clientFactory;

//   Future<Result<LoginResponse>> login(LoginRequest loginRequest) async {
//     final client = _clientFactory();
//     try {
//       final request = await client.post(_host, _port, '/login');
//       request.write(jsonEncode(loginRequest));
//       final response = await request.close();
//       if (response.statusCode == 200) {
//         final stringData = await response.transform(utf8.decoder).join();
//         return Result.ok(LoginResponse.fromJson(jsonDecode(stringData)));
//       } else {
//         return const Result.error(HttpException("Login error"));
//       }
//     } on Exception catch (error) {
//       return Result.error(error);
//     } finally {
//       client.close();
//     }
//   }
// }
