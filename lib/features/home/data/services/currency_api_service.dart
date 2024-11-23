// ignore_for_file: one_member_abstracts

import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/flavor.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

abstract class CurrencyApiServices {
  Future<LatestRatesResponseModel> getLatestRates(
      LatestRatesRequestModel requestModel);
}

@LazySingleton(as: CurrencyApiServices)
class CurrencyApiServicesImpl implements CurrencyApiServices {
  CurrencyApiServicesImpl(this._dio);

  final Dio _dio;
  final StatusChecker _statusChecker = StatusChecker();

  @override
  Future<LatestRatesResponseModel> getLatestRates(
    LatestRatesRequestModel requestModel,
  ) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        '${AppFlavor.instance.baseUrl}/v3/latest',
        queryParameters: requestModel.toMap(),
      );
      return LatestRatesResponseModel.fromMap(response.data!);
    } on DioException catch (error) {
      if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode != null &&
            _statusChecker(error.response!.statusCode) == HTTPCodes.error) {
          final exception = ErrorException(
            error.response!.statusCode!,
            MessageResponseModel.fromMap(
              error.response!.data as Map<String, dynamic>,
            ),
          );

          throw exception;
        } else {
          throw ServerException(error.response);
        }
      }
      rethrow;
    }
  }
}
