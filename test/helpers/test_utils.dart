import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

Widget makeTestableWidget({
  required Widget child,
  List<BlocProvider>? blocProvider,
}) =>
    blocProvider == null
        ? child
        : MultiBlocProvider(
            providers: blocProvider,
            child: child,
          );

Future<BuildContext> pumpLocalizedWidget(
  WidgetTester tester,
  Widget widget, {
  Locale locale = const Locale('en'),
  bool pumpAndSettle = true,
  List<GoRoute> routes = const [],
  List<BlocProvider>? blocProviders,
}) async {
  const initialLocation = '/initial';

  late BuildContext context;
  // tester.view.physicalSize = const Size(375, 812);
  // tester.view.devicePixelRatio = 1.0;

  final builderWidget = GoRoute(
    path: initialLocation,
    builder: (_, state) => Localizations(
      locale: locale,
      delegates: AppLocalizations.localizationsDelegates,
      child: Material(
        child: blocProviders != null
            ? MultiBlocProvider(
                providers: blocProviders,
                child: Builder(
                  builder: (ctx) {
                    context = ctx;
                    return widget;
                  },
                ),
              )
            : Builder(
                builder: (ctx) {
                  context = ctx;
                  return widget;
                },
              ),
      ),
    ),
  );
  await tester.pumpWidget(
    ScreenUtilInit(
      minTextAdapt: true,
      splitScreenMode: true,
      designSize: const Size(375, 812),
      child: MaterialApp.router(
        locale: locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: AppRouter.router(
          initialLocation,
          [builderWidget, ...routes],
        ),
      ),
    ),
  );
  if (pumpAndSettle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
    await tester.pump();
  }
  return context;
}
