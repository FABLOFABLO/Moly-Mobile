import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppEnv {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get kakaoApiKey => dotenv.env['KAKAO_API_KEY'] ?? '';
}
