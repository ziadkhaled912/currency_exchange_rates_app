import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/mocks/latest_rates_request_model_mock.dart';
import 'package:currency_exchange/features/home/data/mocks/latest_rates_response_model_mock.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../core/data/api_manager/faker.dart';
import '../../faker.dart';

void main() {
  late CurrencyRepository repository;
  late MockAPIsManager mockAPIsManager;

  setUpAll(setupFaker);

  setUp(() {
    mockAPIsManager = MockAPIsManager();
    repository = CurrencyRepository(mockAPIsManager);
  });

  group("getLatestRates", () {
    test(
        "should return Right(LatestRatesResponseModel) when apiManager return valid data",
        () async {
      // arrange
      when(
        () => mockAPIsManager
            .send<LatestRatesResponseModel, MessageResponseModel>(
          request: any(named: "request"),
          responseFromMap: any(named: "responseFromMap"),
        ),
      ).thenAnswer((_) async => Right(LatestRatesResponseModelMock.mock));
      // act
      final result =
          await repository.getLatestRates(LatestRatesRequestModelMock.mock);
      // assert
      expect(
          result,
          Right<dynamic, LatestRatesResponseModel>(
              LatestRatesResponseModelMock.mock));
    });

    test(
        "should return Left(ValidationError) when apiManager return invalid data",
        () async {
      // arrange
      final failure = ErrorFailure(
        errorStatus: ErrorStatus.validationError,
        error: MessageResponseModelMock.mock,
      );
      when(
        () => mockAPIsManager
            .send<LatestRatesResponseModel, MessageResponseModel>(
          request: any(named: "request"),
          responseFromMap: any(named: "responseFromMap"),
        ),
      ).thenAnswer((_) async => Left(failure));
      // act
      final result =
          await repository.getLatestRates(LatestRatesRequestModelMock.mock);
      // assert
      expect(result, Left<ErrorFailure, dynamic>(failure));
    });

    test(
        "should return Left(ServiceNotAvailableFailure) when apiManager return Server error",
            () async {
          // arrange
          final failure = ServiceNotAvailableFailure(FailureInfo());
          when(
                () => mockAPIsManager
                .send<LatestRatesResponseModel, MessageResponseModel>(
              request: any(named: "request"),
              responseFromMap: any(named: "responseFromMap"),
            ),
          ).thenAnswer((_) async => Left(failure));
          // act
          final result =
          await repository.getLatestRates(LatestRatesRequestModelMock.mock);
          // assert
          expect(result, Left<ServiceNotAvailableFailure, dynamic>(failure));
        });
  });
}
