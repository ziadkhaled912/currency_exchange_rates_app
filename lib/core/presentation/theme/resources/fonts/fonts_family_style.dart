import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/constants.dart';
import 'package:flutter/material.dart';
//This class methods return the TextStyle object with specific font weight and other styles.
class FontFamilyStyle {
  FontFamilyStyle._();
  static TextStyle standardTextStyleW500(
      {required double fontSize,
        Color color = AppColors.mainText,
        TextDecoration decoration = TextDecoration.none,
        double lineHeight = 1.25}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeight.w500,
         fontFamily: AppConstants.fontFamily,
        decoration: decoration,
        fontSize: fontSize,
        height: lineHeight,
        letterSpacing: 0.0,
      );

  static TextStyle standardTextStyleW700(
      {required double fontSize,
        Color color = AppColors.mainText,
        TextDecoration decoration = TextDecoration.none,
        double lineHeight = 1.25}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeight.w700,
         fontFamily: AppConstants.fontFamily,
        fontSize: fontSize,
        decoration: decoration,
        letterSpacing: 0.0,
        height: lineHeight,
      );

  static TextStyle standardTextStyleW400(
      {required double fontSize,
        Color color = AppColors.secondText,
        TextDecoration decoration = TextDecoration.none,
        double lineHeight = 1.25}) =>
      TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: AppConstants.fontFamily,
        decoration: decoration,
        fontSize: fontSize,
        letterSpacing: 0.0,
        height: lineHeight,
      );
}
