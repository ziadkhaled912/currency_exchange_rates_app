import 'package:currency_exchange/features/home/data/mappers/latest_rates_response_mapper.dart';
import 'package:currency_exchange/features/home/presentation/widgets/dollar_rate_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../helpers/test_utils.dart';
import '../../../../mock/data/latest_rates_response_model_mock.dart';

void main() {
  final mockCurrency =
      LatestRatesResponseModelMock.mock.data?.values.first.toEntity();

  Widget dollarRateCard([double? rate]) => makeTestableWidget(
        child:
            DollarRateCard(currency: rate ?? (1 / (mockCurrency?.value ?? 0))),
      );

  group('Dollar Rate Card Test', () {
    testWidgets('Dollar Rate Card render correctly', (tester) async {
      await pumpLocalizedWidget(tester, dollarRateCard());
      expect(find.byKey(const Key('DollarRateHomeCard')), findsOneWidget);
      expect(find.byKey(const Key('DollarRateCardColumn')), findsOneWidget);
      expect(find.byKey(const Key('DollarRateCardRow')), findsOneWidget);
      expect(find.byKey(const Key('DollarRateCardFlag')), findsOneWidget);
      expect(
          find.byKey(const Key('DollarRateCardCurrencyText')), findsOneWidget);
      expect(find.byKey(const Key('DollarRateCardBodyText')), findsOneWidget);
      expect(
          find.byKey(const Key('DollarRateCardCurrencyValue')), findsOneWidget);
    });

    testWidgets('Dollar Rate Card render with correct currency value',
        (tester) async {
      await pumpLocalizedWidget(tester, dollarRateCard());
      expect(find.text((1 / mockCurrency!.value).toStringAsFixed(2)),
          findsOneWidget);
    });

    testWidgets('Dollar Rate Card should render a (10 char) currency value',
        (tester) async {
      await pumpLocalizedWidget(tester, dollarRateCard(1.000000001));
      expect(find.text('1.00'), findsOneWidget);
    });
  });
}
