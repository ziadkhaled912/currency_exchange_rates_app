// ignore_for_file: lines_longer_than_80_chars

import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model_mock.dart';
import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:currency_exchange/features/home/data/services/currency_api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/data/latest_rates_request_model_mock.dart';
import '../../../../mock/services/mock_currency_api_service.dart';
import '../../faker.dart';

void main() {
  late CurrencyRepository repository;
  late CurrencyApiServices mockApiServices;

  setUpAll(setupFaker);

  setUp(() {
    mockApiServices = MockCurrencyApiServices();
    repository = CurrencyRepositoryImpl(mockApiServices);
  });

  group('getLatestRates', () {
    test(
        'should return Right(LatestRatesResponseModel) when apiManager return valid data',
        () async {
      // arrange
      when(
        () => mockApiServices.getLatestRates(
          any(),
        ),
      ).thenAnswer((_) async => LatestRatesResponseModelMock.mock);
      // act
      final result =
          await repository.getLatestRates(LatestRatesRequestModelMock.mock);
      // assert
      expect(
        result,
        Right<dynamic, LatestRatesResponseModel>(
          LatestRatesResponseModelMock.mock,
        ),
      );
    });

    test('should return Failure when apiManager return invalid data',
        () async {
      // arrange
      const serverException = ServerException(null);
      final failure = UnknownFailure(
        const FailureInfo(
          exception: serverException,
        ),
      );
      when(
        () => mockApiServices.getLatestRates(
          any(),
        ),
      ).thenThrow(serverException);
      // act
      final result =
          await repository.getLatestRates(LatestRatesRequestModelMock.mock);
      // assert
      expect(result, Left<Failure, LatestRatesResponseModel>(failure));
    });
  });
}
