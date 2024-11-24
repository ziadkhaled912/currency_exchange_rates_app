import 'package:currency_exchange/core/presentation/app.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test/helpers/test_utils.dart';
import '../../../test/mock/cubits/mock_currency_cubit.dart';
import '../../../test/mock/data/latest_rates_request_model_mock.dart';

void main() {
  final currencyCubit = MockCurrencyCubit();

  final currenciesListMock = [
    const Currency(
      currencyEnum: CurrencyEnum.usd,
      value: 1.5,
    ),
    const Currency(
      currencyEnum: CurrencyEnum.eur,
      value: 2,
    ),
  ];

  final currencyCalculatorPage = makeTestableWidget(
    child: const App(initialLocation: CurrencyCalculatorPage.id),
    blocProvider: [
      BlocProvider<AuthCubit>.value(value: authCubit),
      BlocProvider<LanguageCubit>.value(value: languageCubit),
    ],
  );

  setUpAll(() async {
    registerFallbackValue(LatestRatesRequestModelMock.mock);
  });

  group('CurrencyCalculator Page Test', () {
    setUpAll(() async {
      await initSignedInUser(
        currencyCubit: currencyCubit,
      );
      when(() => currencyCubit.getLatestRates(any())).thenAnswer(
        (_) async {},
      );
      when(() => currencyCubit.state).thenReturn(
        CurrencyState(currencies: currenciesListMock),
      );
    });

    double calculateCurrency(num amount, CurrencyEnum from, CurrencyEnum to) {
      final firstCurrency = currenciesListMock
          .firstWhere(
            (element) => element.currencyEnum == from,
          )
          .value;
      final secondCurrency = currenciesListMock
          .firstWhere(
            (element) => element.currencyEnum == to,
          )
          .value;
      return amount * (secondCurrency / firstCurrency);
    }

    testWidgets('''
Given user selected From and To Currency and entered valid number value
then it should convert the value to the selected currency
    ''', (tester) async {
      // Act
      const amount = 1;
      const fromCurrency = CurrencyEnum.usd;
      const toCurrency = CurrencyEnum.eur;
      final result = calculateCurrency(amount, fromCurrency, toCurrency);
      await tester.pumpWidget(currencyCalculatorPage);

      // Arrange
      await selectCurrency(
          tester, const Key('FromCurrencyDropdown'), fromCurrency);
      await selectCurrency(tester, const Key('ToCurrencyDropdown'), toCurrency);
      await tester.enterText(
          find.byKey(const Key('CurrencyTextField')), '$amount');

      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('CurrencyResult')), findsOneWidget);
      expect(find.byKey(const Key('CurrencyResultInput')), findsOneWidget);
      expect(find.text('$amount ${fromCurrency.code} ='), findsOneWidget);
      expect(find.text('${result.toStringAsFixed(2)} ${toCurrency.code}'),
          findsOneWidget);
    });

    testWidgets('''
Given user selected From and To Currency and entered invalid number value
then it should show an error message
    ''', (tester) async {
      // Act
      const amount = 'invalid';
      const fromCurrency = CurrencyEnum.usd;
      const toCurrency = CurrencyEnum.eur;
      await pumpLocalizedWidget(tester, currencyCalculatorPage);

      // Arrange
      await selectCurrency(
          tester, const Key('FromCurrencyDropdown'), fromCurrency);
      await selectCurrency(tester, const Key('ToCurrencyDropdown'), toCurrency);
      await tester.enterText(
          find.byKey(const Key('CurrencyTextField')), amount);

      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('CurrencyResult')), findsNothing);
      expect(find.byKey(const Key('CurrencyResultInput')), findsNothing);
      expect(find.text('Please enter valid amount'), findsOneWidget);
    });

    testWidgets('''
Given user selected From and To Currency and entered negative number value
then it should show an error message
    ''', (tester) async {
      // Act
      const amount = '-1';
      const fromCurrency = CurrencyEnum.usd;
      const toCurrency = CurrencyEnum.eur;
      await pumpLocalizedWidget(tester, currencyCalculatorPage);

      // Arrange
      await selectCurrency(
          tester, const Key('FromCurrencyDropdown'), fromCurrency);
      await selectCurrency(tester, const Key('ToCurrencyDropdown'), toCurrency);
      await tester.enterText(
          find.byKey(const Key('CurrencyTextField')), amount);

      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('CurrencyResult')), findsNothing);
      expect(find.byKey(const Key('CurrencyResultInput')), findsNothing);
      expect(find.text('Please enter valid amount'), findsOneWidget);
    });

    testWidgets('''
Given user selected From and To Currency and valid amount and taped on swap button
then it should swap the selected currencies
    ''', (tester) async {
      // Act
      const amount = 1;
      const fromCurrency = CurrencyEnum.usd;
      const toCurrency = CurrencyEnum.eur;
      // swapped currencies result
      final result = calculateCurrency(amount, toCurrency, fromCurrency);
      await pumpLocalizedWidget(tester, currencyCalculatorPage);

      // Arrange
      await selectCurrency(
          tester, const Key('FromCurrencyDropdown'), fromCurrency);
      await selectCurrency(tester, const Key('ToCurrencyDropdown'), toCurrency);
      await tester.enterText(
          find.byKey(const Key('CurrencyTextField')), '$amount');

      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('SwapCurrencyButton')));
      await tester.pumpAndSettle();

      // Assert
      expect(find.byKey(const Key('CurrencyResult')), findsOneWidget);
      expect(find.byKey(const Key('CurrencyResultInput')), findsOneWidget);
      expect(find.text('$amount ${toCurrency.code} ='), findsOneWidget);
      expect(find.text('${result.toStringAsFixed(2)} ${fromCurrency.code}'),
          findsOneWidget);
    });
  });
}

Future<void> selectCurrency(
  WidgetTester tester,
  Key key,
  CurrencyEnum currencyEnum,
) async {
  await tester.tap(find.byKey(key));
  await tester.pumpAndSettle();
  await tester.tap(find.text(currencyEnum.name));
  await tester.pumpAndSettle();
}
