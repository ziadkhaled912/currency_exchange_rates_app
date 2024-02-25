import 'package:currency_exchange/core/helpers/app_faker.dart';
import 'package:currency_exchange/features/home/data/models/response_models/currency_model.dart';

class CurrencyModelMock {
  static final mock = random;

  //*this return the !different! instance every time it's called
  static CurrencyModel get random => CurrencyModel(
    code: AppFaker.currencyCode,
    value: AppFaker.randomDouble,
  );

  static List<CurrencyModel> get randomList => List.generate(
    AppFaker.randomInt(max: 10),
        (index) => random,
  );
}
