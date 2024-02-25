import 'package:currency_exchange/core/helpers/app_faker.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';

class MetaModelMock {
  //*this return the !same! instance every time it's called
  static final mock = random;

  //*this return the !different! instance every time it's called
  static Meta get random => Meta(
    lastUpdatedAt: AppFaker.dateTime,
  );
}