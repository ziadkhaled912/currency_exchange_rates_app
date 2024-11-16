part of 'currency_calculator_cubit.dart';

class CurrencyCalculatorState extends Equatable {
  const CurrencyCalculatorState({
    required this.currencies,
    this.firstSelectedCurrency,
    this.secondSelectedCurrency,
    this.amount,
    this.result,
  });

  final List<Currency> currencies;
  final Currency? firstSelectedCurrency;
  final Currency? secondSelectedCurrency;
  final String? amount;
  final double? result;

  CurrencyCalculatorState copyWith({
    List<Currency>? currencies,
    Nullable<Currency?>? firstSelectedCurrency,
    Nullable<Currency?>? secondSelectedCurrency,
    Nullable<String?>? amount,
    double? result,
  }) {
    return CurrencyCalculatorState(
      currencies: currencies ?? this.currencies,
      firstSelectedCurrency: firstSelectedCurrency == null
          ? this.firstSelectedCurrency
          : firstSelectedCurrency.value,
      secondSelectedCurrency: secondSelectedCurrency == null
          ? this.secondSelectedCurrency
          : secondSelectedCurrency.value,
      amount: amount == null ? this.amount : amount.value,
      result: result ?? this.result,
    );
  }

  @override
  List<Object?> get props => [
        currencies,
        firstSelectedCurrency,
        secondSelectedCurrency,
        amount,
        result,
      ];
}
