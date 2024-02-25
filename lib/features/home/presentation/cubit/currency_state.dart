part of 'currency_cubit.dart';

class CurrencyState extends Equatable {
  const CurrencyState({
    this.isLoading = false,
    this.failure,
    this.currencies,
  });

  final bool isLoading;
  final Failure? failure;
  final List<Currency>? currencies;

  CurrencyState requestLoading() => copyWith(
    isLoading: true,
    failure: null,
    currencies: null,
  );

  CurrencyState requestSuccess(List<Currency> currencies) => copyWith(
    isLoading: false,
    currencies: currencies,
  );

  CurrencyState requestFail(Failure failure) => copyWith(
    isLoading: false,
    failure: failure,
  );

  CurrencyState copyWith({
    bool? isLoading,
    Failure? failure,
    List<Currency>? currencies,
  }) {
    return CurrencyState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      currencies: currencies ?? this.currencies,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure, currencies];
}
