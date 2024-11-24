import 'package:flutter_test/flutter_test.dart';

import '../../../../mock/data/latest_rates_request_model_mock.dart';

void main() {
  test(
    'LatestRatesRequestModel toMap should have the right params',
    () async {
      // act
      final map = LatestRatesRequestModelMock.mock.toMap();

      // assert
      expect(
        map['base_currency'],
        LatestRatesRequestModelMock.currencyMock.code,
      );
      expect(
        map['currencies'],
        LatestRatesRequestModelMock.currenciesMock.map((e) => e.code).join(','),
      );
    },
  );
}
