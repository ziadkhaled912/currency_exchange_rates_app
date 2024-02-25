import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';

class LatestRatesRequestModelMock {
  static const currencyMock = CurrencyEnum.usd;
  static const currenciesMock = [CurrencyEnum.usd, CurrencyEnum.egp, CurrencyEnum.aed];

  static final mock = LatestRatesRequestModel(
    baseCurrency: currencyMock,
    currencies: currenciesMock,
  );
}
