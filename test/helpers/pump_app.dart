import 'package:currency_exchange/core/presentation/theme/app_light_theme.dart';
import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

extension PumpApp on WidgetTester {
  Future<void> pumpApp(Widget widget) {
    return pumpWidget(
      ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp.router(
            routerConfig: locator<AppRouter>().config(),
            theme: AppLightTheme().themeData,
          );
        },
      ),
    );
  }
}
