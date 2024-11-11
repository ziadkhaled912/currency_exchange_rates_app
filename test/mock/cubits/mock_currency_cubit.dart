import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/features/home/data/mappers/latest_rates_response_mapper.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';

import '../data/currency_model_mock.dart';

class MockCurrencyCubit extends MockCubit<CurrencyState>
    implements CurrencyCubit {}

final currenciesList =
    CurrencyModelMock.randomList.map((e) => e.toEntity()).toList();

final currencyState = CurrencyState(
  currencies: currenciesList,
);

void setupWhenListen(CurrencyCubit cubit, [List<CurrencyState>? states]) =>
    whenListen(
      cubit,
      states != null
          ? Stream.fromIterable(states)
          : Stream.value(currencyState),
      initialState: states?.first ?? currencyState,
    );
