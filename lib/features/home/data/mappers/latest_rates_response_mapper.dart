import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:currency_exchange/features/home/data/models/response_models/currency_model.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';

extension LatestRatesResponseMapper on CurrencyModel {
  Currency toEntity() => Currency(
        currencyEnum:
            CurrencyEnum.values.firstWhere((element) => element.code == code),
        value: value,
      );
}
