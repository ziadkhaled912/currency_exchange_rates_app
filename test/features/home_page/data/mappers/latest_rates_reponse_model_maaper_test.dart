import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:currency_exchange/features/home/data/mappers/latest_rates_response_mapper.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../mock/data/currency_model_mock.dart';

void main() {
  test(
    // ignore: lines_longer_than_80_chars
    'it should return Currency entity with enum and value when mapping from CurrencyModel',
    () {
      // arrange
      final currencyModel = CurrencyModelMock.mock;

      // act
      final currency = currencyModel.toEntity();

      // assert
      expect(currency.currencyEnum, CurrencyEnum.egp);
      expect(currency.value, currencyModel.value);
    },
  );

  test(
    // ignore: lines_longer_than_80_chars
    'it should return Currency entity with USD enum when mapping from Random CurrencyModel code',
    () {
      // arrange
      final currencyModel = CurrencyModelMock.random;

      // act
      final currency = currencyModel.toEntity();

      // assert
      expect(currency.currencyEnum, CurrencyEnum.usd);
      expect(currency.value, currencyModel.value);
    },
  );
}
