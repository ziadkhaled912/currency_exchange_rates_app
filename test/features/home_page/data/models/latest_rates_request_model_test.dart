import 'package:currency_exchange/features/home/data/mocks/latest_rates_request_model_mock.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    "LatestRatesRequestModel toMap should have the right params",
    () async {
      // act
      final map = await LatestRatesRequestModelMock.mock.toMap();

      // assert
      expect(map["base_currency"], LatestRatesRequestModelMock.currencyMock.code);
      expect(map["currencies"], LatestRatesRequestModelMock.currenciesMock.map((e) => e.code).join(","));
    },
  );
}
