import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:mocktail/mocktail.dart';

import '../../core/data/api_manager/faker.dart';

class MockCurrencyRepositoryMock extends Mock implements CurrencyRepository {}

class LatestRatesRequestModelFake extends Fake implements LatestRatesResponseModel {}

void setupFaker() {
  registerFallbackValue(RequestFake());
  registerFallbackValue(LatestRatesRequestModelFake());
}
