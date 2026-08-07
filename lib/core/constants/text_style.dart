import 'package:flutter/material.dart';
import 'package:moly_mobile/core/constants/color.dart';

abstract final class MolyTextStyle {
  /// Headline
  static const headline1 = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 40,
  );

  static const headline2 = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 28,
  );

  static const headline3 = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 24,
  );

  /// Body
  static const body = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 20,
  );

  /// Text
  static const textBold = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 18,
  );

  static const textMedium = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );

  /// Button
  static const buttonBold = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 16,
  );

  static const buttonMedium = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  /// Caption
  static const captionBold = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 14,
  );

  static const captionMedium = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );

  static const caption1Bold = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w700,
    fontSize: 12,
  );

  static const caption1Medium = TextStyle(
    fontFamily: 'SpoqaHanSansNeo',
    color: MolyColor.black,
    fontWeight: FontWeight.w500,
    fontSize: 12,
  );
}
