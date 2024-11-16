import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/mappers/latest_rates_response_mapper.dart';
import 'package:currency_exchange/features/home/presentation/cubit/currency_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mock/data/latest_rates_request_model_mock.dart';
import '../../../mock/data/latest_rates_response_model_mock.dart';
import '../../../mock/repository/mock_currency_repository.dart';

void main() {
  final repository = MockCurrencyRepository();
  late CurrencyCubit cubit;

  setUp(() {
    cubit = CurrencyCubit(repository);
  });

  group(
    'getLatestRates Tests',
    () {
      blocTest<CurrencyCubit, CurrencyState>(
        '''
CurrencyCubit emits loadingState and successState when getLatestRates return Right
''',
        setUp: () => when(
          () => repository.getLatestRates(LatestRatesRequestModelMock.mock),
        ).thenAnswer(
          (_) async => Right(LatestRatesResponseModelMock.mock),
        ),
        build: () => cubit,
        act: (bloc) => cubit.getLatestRates(LatestRatesRequestModelMock.mock),
        expect: () => [
          const CurrencyState(
            isLoading: true,
          ),
          CurrencyState(
            currencies: LatestRatesResponseModelMock.mock.data?.values
                    .map((e) => e.toEntity())
                    .toList() ??
                [],
          ),
        ],
      );

      blocTest<CurrencyCubit, CurrencyState>(
        '''
CurrencyCubit emits loadingState and failState when getLatestRates return Left
''',
        setUp: () => when(
          () => repository.getLatestRates(LatestRatesRequestModelMock.mock),
        ).thenAnswer(
          (_) async => Left(ConnectionFailure()),
        ),
        build: () => cubit,
        act: (bloc) => cubit.getLatestRates(LatestRatesRequestModelMock.mock),
        expect: () => [
          const CurrencyState(
            isLoading: true,
          ),
          CurrencyState(
            failure: ConnectionFailure(),
          ),
        ],
      );

      blocTest<CurrencyCubit, CurrencyState>(
        '''
given the current state is fail and the repository return Right then Cubit should emit loading then success''',
        setUp: () => when(
          () => repository.getLatestRates(LatestRatesRequestModelMock.mock),
        ).thenAnswer(
          (_) async => Right(LatestRatesResponseModelMock.mock),
        ),
        seed: () => CurrencyState(
          failure: ConnectionFailure(),
        ),
        build: () => cubit,
        act: (bloc) => cubit.getLatestRates(LatestRatesRequestModelMock.mock),
        expect: () => [
          const CurrencyState(
            isLoading: true,
          ),
          CurrencyState(
            currencies: LatestRatesResponseModelMock.mock.data?.values
                    .map((e) => e.toEntity())
                    .toList() ??
                [],
          ),
        ],
      );
    },
  );
}
