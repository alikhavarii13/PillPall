import 'package:dio/dio.dart';

class GenerateDescriptionApi {
  final Dio dio = Dio();

  Future<String> generate(String pillName) async {
    try {
      final response = await dio.post(
        "https://api.openai.com/v1/chat/completions",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ",
          },
        ),
        data: {
          "model": "gpt-4.1-mini",
          "input":
              "Give me a short medical description for the pill: $pillName",
        },
      );
      return response.data;
    } catch (e) {
      print("Error: $e");
      return "Something went wrong!";
    }
  }
}
