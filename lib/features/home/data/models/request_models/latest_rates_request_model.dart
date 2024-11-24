import 'package:currency_exchange/features/home/data/enums/currency_enum.dart';
import 'package:equatable/equatable.dart';

class LatestRatesRequestModel extends Equatable {
  const LatestRatesRequestModel({
    required this.baseCurrency,
    required this.currencies,
  });

  final CurrencyEnum baseCurrency;
  final List<CurrencyEnum> currencies;

  @override
  List<Object?> get props => [baseCurrency, currencies];

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};
    map['base_currency'] = baseCurrency.code;
    map['currencies'] = currencies.map((e) => e.code).join(',');
    return map;
  }
}
