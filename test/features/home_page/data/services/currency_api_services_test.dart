import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/helpers/app_faker.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model_mock.dart';
import 'package:currency_exchange/features/home/data/services/currency_api_service.dart';
import 'package:currency_exchange/flavor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mock/data/latest_rates_request_model_mock.dart';
import '../../faker.dart';

void main() {
  late CurrencyApiServices currencyApiServices;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    currencyApiServices = CurrencyApiServicesImpl(mockDio);
  });

  group('getLatestRates', () {
    test(
      '''
    should perform GET request on URL 
    with base currency and list of currencies code''',
      () {
        // arrange
        const requestModel = LatestRatesRequestModelMock.mock;
        when(
          () => mockDio.get<Map<String, dynamic>>(
            any(),
            queryParameters: requestModel.toMap(),
          ),
        ).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: LatestRatesResponseModelMock.mock.toMap(),
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );
        // act
        currencyApiServices.getLatestRates(requestModel);
        // assert
        verify(
          () => mockDio.get<Map<String, dynamic>>(
            '${AppFlavor.instance.baseUrl}/v3/latest',
            queryParameters: requestModel.toMap(),
          ),
        ).called(1);
      },
    );

    test(
      '''
    should return LatestRatesResponseModel when the api return 200 success response''',
      () async {
        // arrange
        const requestModel = LatestRatesRequestModelMock.mock;
        when(
          () => mockDio.get<Map<String, dynamic>>(
            any(),
            queryParameters: requestModel.toMap(),
          ),
        ).thenAnswer(
          (_) async => Response<Map<String, dynamic>>(
            data: LatestRatesResponseModelMock.mock.toMap(),
            statusCode: 200,
            requestOptions: RequestOptions(),
          ),
        );
        // act
        final result = await currencyApiServices.getLatestRates(requestModel);
        // assert
        expect(result, LatestRatesResponseModelMock.mock);
      },
    );

    test('''
should throw ErrorException when the api return 400 bad request response''',
        () async {
      // arrange
      const requestModel = LatestRatesRequestModelMock.mock;
      when(
        () => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: requestModel.toMap(),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            data: {
              'message': AppFaker.sentence,
            },
            statusCode: 400,
            requestOptions: RequestOptions(),
          ), 
          requestOptions: RequestOptions(),
        ),
      );
      // act
      final call = currencyApiServices.getLatestRates(requestModel);
      // assert
      expect(() => call, throwsA(isA<ErrorException>()));
    });

    test('''
should throw ServerException when the api return 500 server error response''',
        () async {
      // arrange
      const requestModel = LatestRatesRequestModelMock.mock;
      when(
        () => mockDio.get<Map<String, dynamic>>(
          any(),
          queryParameters: requestModel.toMap(),
        ),
      ).thenThrow(
        DioException(
          type: DioExceptionType.badResponse,
          response: Response(
            data: {
              'message': AppFaker.sentence,
            },
            statusCode: 500,
            requestOptions: RequestOptions(),
          ), 
          requestOptions: RequestOptions(),
        ),
      );
      // act
      final call = currencyApiServices.getLatestRates(requestModel);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
