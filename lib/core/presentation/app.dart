import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/core/presentation/theme/app_light_theme.dart';
import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class App extends StatefulWidget {
  const App({super.key, this.initialLocation});

  final String? initialLocation;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final _router = AppRouter.router(widget.initialLocation);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<LanguageCubit, LanguageState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: _router,
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
