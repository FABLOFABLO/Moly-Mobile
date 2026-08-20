import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_sdk/kakao_map_sdk.dart';
import 'package:moly_mobile/core/constants/color.dart';
import 'package:moly_mobile/core/env/app_env.dart';
import 'package:moly_mobile/core/router/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env', isOptional: true);

  final kakaoApiKey = AppEnv.kakaoApiKey;
  if (kakaoApiKey.isEmpty) {
    throw StateError('KAKAO_API_KEY가 비어 있습니다. .env 파일을 확인하세요.');
  }
  await KakaoMapSdk.instance.initialize(kakaoApiKey);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'moly_mobile',
      theme: ThemeData(
        fontFamily: 'SpoqaHanSansNeo',
        scaffoldBackgroundColor: MolyColor.mn,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MolyColor.brown100,
          primary: MolyColor.brown100,
          error: MolyColor.error,
        ),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
