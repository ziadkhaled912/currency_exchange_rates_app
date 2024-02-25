import 'package:currency_exchange/features/home/data/enums/currency.dart';
import 'package:equatable/equatable.dart';

class Currency extends Equatable {
  const Currency({required this.currencyEnum, required this.value});

  final CurrencyEnum currencyEnum;
  final double value;

  @override
  List<Object?> get props => [currencyEnum, value];
}
