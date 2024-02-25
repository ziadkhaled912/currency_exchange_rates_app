import 'package:currency_exchange/core/presentation/theme/app_light_theme.dart';
import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          routerConfig: locator<AppRouter>().config(),
          // localizationsDelegates: AppLocalizations.localizationsDelegates,
          // supportedLocales: AppLocalizations.supportedLocales,
          // locale: state.locale,
          debugShowCheckedModeBanner: false,
          theme: AppLightTheme().themeData,
        );
      },
    );
  }
}
