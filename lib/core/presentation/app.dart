import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/core/presentation/theme/app_light_theme.dart';
import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class App extends StatelessWidget {
  const App({super.key, this.appRouter});

  final GoRouter? appRouter;
  

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: appRouter ?? AppRouter.router(),
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              theme: AppLightTheme().themeData,
            );
          },
        );
      },
    );
  }
}
