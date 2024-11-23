import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/core/services/router/app_router.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/auth/core/data/repository/auth_repository.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:currency_exchange/flavor.dart';
import 'package:currency_exchange/l10n/l10n.dart';
import 'package:dartz/dartz.dart';
import '../mock/cubits/mock_auth_cubit.dart';
import '../mock/cubits/mock_currency_cubit.dart';
import '../mock/cubits/mock_language_cubit.dart';
import '../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import '../mock/data/latest_rates_request_model_mock.dart';
import '../mock/repository/mock_auth_repository.dart';
import '../mock/repository/mock_currency_repository.dart';

final authCubit = MockAuthCubit();
final languageCubit = MockLanguageCubit();
final currencyCubit = MockCurrencyCubit();
final authRepository = MockAuthRepository();

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
        // child: blocProviders != null
        //     ? MultiBlocProvider(
        //         providers: blocProviders,
        //         child: Builder(
        //           builder: (ctx) {
        //             context = ctx;
        //             return widget;
        //           },
        //         ),
        //       )
        //     :
        child: Builder(
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
      child: blocProviders != null
          ? MultiBlocProvider(
              providers: blocProviders,
              child: MaterialApp.router(
                locale: locale,
                supportedLocales: AppLocalizations.supportedLocales,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                routerConfig: AppRouter.router(
                  initialLocation,
                  [builderWidget, ...routes],
                ),
              ),
            )
          : MaterialApp.router(
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

Future<void> initSignedInUser() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.instance.flavor = Flavor.mock;
  await configureTestDependencies();
  when(() => authCubit.state).thenReturn(const AuthState(
    currentUser: AuthUserModelMock.mockAuthUserModel,
    uid: AuthUserModelMock.mockUid,
  ));
  when(() => languageCubit.state).thenReturn(const LanguageState());
}

Future<void> initSignedOutUser() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFlavor.instance.flavor = Flavor.mock;
  await configureTestDependencies();
  locator
    ..unregister<AuthRepository>()
    ..registerLazySingleton<AuthRepository>(
        () => authRepository)
    ..unregister<LoginCubit>()
    ..registerFactory<LoginCubit>(
        () => LoginCubit(authRepository));
  when(() => authCubit.state).thenReturn(const AuthState());
  when(() => languageCubit.state).thenReturn(const LanguageState());
}

Future<void> configureTestDependencies() async {
  await locator.reset();
  configureDependencies();
}
