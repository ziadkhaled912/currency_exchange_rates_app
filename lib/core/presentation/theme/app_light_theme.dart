import 'package:currency_exchange/core/presentation/theme/resources/fonts/fonts_family_style.dart';
import 'package:currency_exchange/core/presentation/theme/resources/values/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        titleLarge: FontFamilyStyle.standardTextStyleW700(fontSize: 32.sp,),
        titleMedium: FontFamilyStyle.standardTextStyleW700(fontSize: 30.sp),
        titleSmall: FontFamilyStyle.standardTextStyleW700(fontSize: 22.sp),
        labelMedium: FontFamilyStyle.standardTextStyleW500(fontSize: 18.sp),
        bodyMedium: FontFamilyStyle.standardTextStyleW700(fontSize: 17.sp),
        bodySmall: FontFamilyStyle.standardTextStyleW500(fontSize: 16.sp),
        bodyLarge: FontFamilyStyle.standardTextStyleW500(fontSize: 18.sp,),
        labelSmall: FontFamilyStyle.standardTextStyleW400(fontSize: 14.sp,),

      ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      titleTextStyle: FontFamilyStyle.standardTextStyleW700(fontSize: 18.sp),
      centerTitle: true,
      elevation: 0,
    ),
    tabBarTheme: TabBarTheme(
      labelStyle: FontFamilyStyle.standardTextStyleW700(fontSize: 13.sp),
      labelColor: Colors.black,
      unselectedLabelStyle: FontFamilyStyle.standardTextStyleW400(fontSize: 13.sp),
      unselectedLabelColor: Colors.black54,
      indicatorColor: Colors.black,
  ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.lightPrimary,
        textStyle: FontFamilyStyle.standardTextStyleW700(fontSize: 15.sp),
      ),
    ),
  );

}