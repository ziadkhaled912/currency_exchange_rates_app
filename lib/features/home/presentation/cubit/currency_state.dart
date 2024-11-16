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
    failure: Nullable(null),
    currencies: Nullable(null),
  );

  CurrencyState requestSuccess(List<Currency> currencies) => copyWith(
    isLoading: false,
    currencies: Nullable(currencies),
  );

  CurrencyState requestFail(Failure failure) => copyWith(
    isLoading: false,
    failure: Nullable(failure),
  );

  CurrencyState copyWith({
    bool? isLoading,
    Nullable<Failure?>? failure,
    Nullable<List<Currency>?>? currencies,
  }) {
    return CurrencyState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure == null ? this.failure : failure.value,
      currencies: currencies == null ? this.currencies : currencies.value,
    );
  }

  @override
  List<Object?> get props => [isLoading, failure, currencies];
}
