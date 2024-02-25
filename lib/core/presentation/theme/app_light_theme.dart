import 'package:currency_exchange/core/extenstions/screen_util.dart';
import 'package:currency_exchange/core/presentation/theme/resources/fonts/fonts_family_style.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:flutter/material.dart';

class AppLightTheme  {
  static final AppLightTheme _instance = AppLightTheme._();

  AppLightTheme._();

  factory AppLightTheme() => _instance;
  ThemeData get themeData => ThemeData(
    scaffoldBackgroundColor: Colors.white,
      primaryColor: AppColors.primary,
      // disabledColor: AppColors.color909090,
      // primaryColorDark: AppColors.color000000,
      // primaryColorLight: AppColors.colorFFFFFF,
      useMaterial3: false,
      // androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      // sliderTheme: const SliderThemeData(
      //     activeTrackColor: AppColors.color000000,
      //     inactiveTrackColor: AppColors.colorE0E0E0
      // ),
      textTheme: TextTheme(
        titleLarge: FontFamilyStyle.standardTextStyleW700(fontSize: 32.toFont,),
        titleMedium: FontFamilyStyle.standardTextStyleW700(fontSize: 30.toFont),
        titleSmall: FontFamilyStyle.standardTextStyleW700(fontSize: 22.toFont),
        labelMedium: FontFamilyStyle.standardTextStyleW500(fontSize: 18.toFont),
        bodyMedium: FontFamilyStyle.standardTextStyleW700(fontSize: 17.toFont),
        bodySmall: FontFamilyStyle.standardTextStyleW500(fontSize: 16.toFont),
        bodyLarge: FontFamilyStyle.standardTextStyleW500(fontSize: 18.toFont,),
        labelSmall: FontFamilyStyle.standardTextStyleW400(fontSize: 14.toFont,),

      ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: FontFamilyStyle.standardTextStyleW700(fontSize: 18.toFont),
      centerTitle: true,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: FontFamilyStyle.standardTextStyleW700(fontSize: 13.toFont),
      labelColor: Colors.black,
      unselectedLabelStyle: FontFamilyStyle.standardTextStyleW400(fontSize: 13.toFont),
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.black,
  ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        textStyle: FontFamilyStyle.standardTextStyleW700(fontSize: 15.toFont),
      ),
    ),
  );

}