import 'package:currency_exchange/features/home/data/models/response_models/currency_model_mock.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/models/response_models/meta_mock.dart';

class LatestRatesResponseModelMock {
  //*this return the !same! instance every time it's called
  static final mock = random;

  //*this return the !different! instance every time it's called
  static LatestRatesResponseModel get random => LatestRatesResponseModel(
        data: { for (final e in CurrencyModelMock.randomList) e.code : e },
    meta: MetaModelMock.random,
      );
}
