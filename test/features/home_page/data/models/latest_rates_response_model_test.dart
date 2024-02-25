import 'package:currency_exchange/features/home/data/mocks/latest_rates_response_model_mock.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ContactUsResponseModel should be able to convert from and to json',
      () async {
    // arrange
    final json = LatestRatesResponseModelMock.mock.toMap();
    // act
    final contactUs = LatestRatesResponseModel.fromMap(json);
    // assert
    expect(contactUs, LatestRatesResponseModelMock.mock);
  });
}
