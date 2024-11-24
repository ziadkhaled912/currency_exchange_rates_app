import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';

import '../../mock/data/latest_rates_request_model_mock.dart';

class MockCurrencyRepositoryMock extends Mock implements CurrencyRepository {}

class LatestRatesRequestModelFake extends Fake
    implements LatestRatesResponseModel {}

    class MockDio extends Mock implements Dio {}

void setupFaker() {
  registerFallbackValue(LatestRatesRequestModelMock.mock);
}
