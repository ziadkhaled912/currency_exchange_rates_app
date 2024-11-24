// ignore_for_file: inference_failure_on_instance_creation

import 'package:currency_exchange/core/presentation/app.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/login/presentation/pages/login_page.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model_mock.dart';
import 'package:currency_exchange/features/home_base/presentation/home_base_page.dart';
import 'package:currency_exchange/features/splash/view/splash_screen.dart';
import 'package:dartz/dartz.dart';
import 'package:faker/faker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test/helpers/test_utils.dart';
import '../../../test/mock/data/latest_rates_request_model_mock.dart';

void main() {
  final splashPage = makeTestableWidget(
    child: const App(),
    blocProvider: [
      BlocProvider<AuthCubit>.value(value: authCubit),
      BlocProvider<LanguageCubit>.value(value: languageCubit),
    ],
  );

  setUpAll(() async {
    registerFallbackValue(LatestRatesRequestModelMock.mock);
  });

  group('SplashPage Logged In Test', () {
    setUpAll(() async {
      await initSignedInUser();
      when(() => currencyRepository.getLatestRates(any()))
          .thenAnswer((_) async => Right(LatestRatesResponseModelMock.mock));
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is logged in
      When app is started
      Then should navigate to HomeBasePage
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(splashPage);
      await tester.pumpAndSettle();
      // Act
      await awaitSplash(tester);
      // Assert
      expect(find.byType(SplashPage), findsNothing);
      expect(find.byType(HomeBasePage), findsOneWidget);
    });
  });

  group('SplashPage Not Logged In Test', () {
    setUpAll(() async {
      await initSignedOutUser();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is not logged in
      When app is started
      Then should navigate to LoginPage
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(splashPage);
      await tester.pumpAndSettle();
      // Act
      await awaitSplash(tester);
      // Assert
      expect(find.byType(SplashPage), findsNothing);
      expect(find.byType(LoginPage), findsOneWidget);
    });
  });
}

Future<void> awaitSplash(WidgetTester tester) async {
  await Future.delayed(const Duration(seconds: 1));
  await tester.pumpAndSettle();
}
