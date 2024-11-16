import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/helpers/nullable.dart';
import 'package:currency_exchange/features/home/domain/entities/currency.dart';
import 'package:equatable/equatable.dart';

part 'currency_calculator_state.dart';

class CurrencyCalculatorCubit extends Cubit<CurrencyCalculatorState> {
  CurrencyCalculatorCubit(List<Currency> currencies)
      : super(CurrencyCalculatorState(currencies: currencies));

  void setFirstSelectedCurrency(Currency currency) {
    emit(state.copyWith(firstSelectedCurrency: Nullable(currency)));
    _calculateResult();
  }

  void setSecondSelectedCurrency(Currency currency) {
    emit(state.copyWith(secondSelectedCurrency: Nullable(currency)));
    _calculateResult();
  }

  void setAmount(String amount) {
    emit(state.copyWith(amount: Nullable(amount.isEmpty ? '0' : amount)));
    _calculateResult();
  }

  void swapCurrencies() {
    if (state.firstSelectedCurrency == null ||
        state.secondSelectedCurrency == null) return;
    emit(state.copyWith(
      firstSelectedCurrency: Nullable(state.secondSelectedCurrency),
      secondSelectedCurrency: Nullable(state.firstSelectedCurrency),
    ));
    _calculateResult();
  }

  void _calculateResult() {
    if (state.firstSelectedCurrency == null ||
        state.secondSelectedCurrency == null ||
        state.amount == null) {
      if (state.result != null) emit(state.copyWith(result: 0));
      return;
    }

    final firstCurrency = state.firstSelectedCurrency!.value;
    final secondCurrency = state.secondSelectedCurrency!.value;
    final amount = double.tryParse(state.amount!);

    if (amount == null || amount <= 0) return;

    final result = amount * (secondCurrency / firstCurrency);

    emit(state.copyWith(result: result));
  }
}
