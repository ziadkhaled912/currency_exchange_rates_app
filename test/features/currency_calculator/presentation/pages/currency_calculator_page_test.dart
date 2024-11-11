import 'package:currency_exchange/features/currency_calculator/presentation/pages/currency_calculator_page.dart';
import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_utils.dart';
import '../../../../mock/cubits/mock_currency_cubit.dart';

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
    child: Scaffold(
      body: CurrencyCalculatorPage(
        currencyCubit: currencyCubit,
      ),
    ),
    blocProvider: [
      BlocProvider(create: (_) => currencyCubit),
    ],
  );

  group('CurrencyCalculator Page Test', () {
    setUpAll(() async {
      setupWhenListen(
          currencyCubit, [CurrencyState(currencies: currenciesListMock)]);
    });

    double convertCurrency(double value, CurrencyEnum currencyEnum) {
    final currency = currenciesListMock.firstWhere(
      (element) => element.currencyEnum == currencyEnum,
    );
    return value * currency.value;
  }

    testWidgets('''
Given user entered valid value and selected currency
then it should convert the value to the selected currency
    ''', (tester) async {
      await pumpLocalizedWidget(tester, currencyCalculatorPage);
      final dropdown = find.byKey(const Key('CurrencyDropdown'));
      await tester.tap(dropdown);
      await tester.pumpAndSettle();
      await tester.tap(find.text(CurrencyEnum.usd.name));
      await tester.enterText(find.byKey(const Key('CurrencyTextField')), '1');

      await tester.pumpAndSettle();

      expect(find.byKey(const Key('CurrencyResult')), findsOneWidget);
      expect(find.text(convertCurrency(1, CurrencyEnum.usd).toStringAsFixed(2)),
          findsOneWidget);
      expect(find.text(CurrencyEnum.usd.code), findsOneWidget);
    });
  });

  
}
