import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/enums/currency.dart';

class LatestRatesRequestModel extends RequestModel {
  LatestRatesRequestModel({
    required this.baseCurrency,
    required this.currencies,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  final CurrencyEnum baseCurrency;
  final List<CurrencyEnum> currencies;

  @override
  List<Object?> get props => [baseCurrency, currencies];

  @override
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{};
    map["base_currency"] = baseCurrency.code;
    map["currencies"] = currencies.map((e) => e.code).join(",");
    return map;
  }
}
