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
            "Authorization":
                "Bearer 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", // put your key here
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
