import 'package:currency_exchange/core/presentation/app.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model_mock.dart';
import 'package:currency_exchange/features/home/presentation/pages/home_page.dart';
import 'package:currency_exchange/features/settings/presentation/pages/settings_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test/helpers/test_utils.dart';
import '../../../test/mock/data/latest_rates_request_model_mock.dart';

void main() {
  final currencyCalculatorPage = makeTestableWidget(
    child: const App(initialLocation: HomePage.id),
    blocProvider: [
      BlocProvider<AuthCubit>.value(value: authCubit),
      BlocProvider<LanguageCubit>.value(value: languageCubit),
    ],
  );

  setUpAll(() async {
    registerFallbackValue(LatestRatesRequestModelMock.mock);
    when(() => currencyRepository.getLatestRates(any())).thenAnswer(
      (_) async => Right(LatestRatesResponseModelMock.mock),
    );
  });

  group('HomeBasePage Navigation Test', () {
    setUpAll(() async {
      await initSignedInUser();
    });

    testWidgets('''
      Given user is signed in and on the home page
      Then user should be view home page
''', (tester) async {
      // Arrange
      await tester.pumpWidget(currencyCalculatorPage);

      // Assert
      expect(find.byType(HomePage), findsOneWidget);
    });

    testWidgets('''
      Given user is signed in and on the home page
      When user taps on the currency calculator button
      Then user should be navigated to the currency calculator page
''', (tester) async {
      // Arrange
      await tester.pumpWidget(currencyCalculatorPage);

      // Act
      final currencyCalculatorButton = find.text('Calculator');
      await tester.tap(currencyCalculatorButton);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(CurrencyCalculatorPage), findsOneWidget);
    });

    testWidgets('''
      Given user is signed in and on the home page
      When user taps on the Settings button
      Then user should be navigated to the Settings page
''', (tester) async {
      // Arrange
      await tester.pumpWidget(currencyCalculatorPage);

      // Act
      final settingsButton = find.text('Settings');
      await tester.tap(settingsButton);
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(SettingsPage), findsOneWidget);
    });
  });

  group('HomePage Test', () {
    setUpAll(() async {
      await initSignedInUser();
    });

    testWidgets(
      '''
      Given user is signed in and on the home page
      User Should see loading indicator then the latest rates list
      ''',
      (tester) async {
        // Arrange
        await tester.runAsync(() async {
          when(() => currencyRepository.getLatestRates(any())).thenAnswer(
            (_) async => Future.delayed(
              const Duration(milliseconds: 500),
              () => Right(LatestRatesResponseModelMock.mock),
            ),
          );
          await tester.pumpWidget(currencyCalculatorPage);

          // Act
          await tester.pump(); // Triggers the loading state

          // Assert
          expect(find.byKey(const Key('DollarRateCardLoading')),
              findsOneWidget);
          await tester.pump(const Duration(milliseconds: 500));
          expect(
              find.byKey(const Key('DollarRateCardLoading')), findsNothing);
        });
      },
    );
  });
}
