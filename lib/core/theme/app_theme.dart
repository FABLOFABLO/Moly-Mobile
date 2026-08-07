import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';

abstract final class AppTheme {
  static ThemeData get light => ThemeData(
        fontFamily: 'SpoqaHanSansNeo',
        scaffoldBackgroundColor: MolyColor.hm,
        colorScheme: ColorScheme.fromSeed(
          seedColor: MolyColor.brown,
          primary: MolyColor.brown,
          error: MolyColor.error,
        ),
        useMaterial3: true,
      );
}
