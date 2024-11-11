import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/services/currency_api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrencyRepository {
  CurrencyRepository(this._homeApiServices);

  final CurrencyApiServices _homeApiServices;
  final FailureHandler _failureHandler = FailureHandler();

  Future<Either<Failure, LatestRatesResponseModel>> getLatestRates(
    LatestRatesRequestModel requestModel,
  ) async {
    try {
      final response = await _homeApiServices.getLatestRates(requestModel);
      return Right(response);
    } catch (error) {
      return Left(
        _failureHandler.handle(
          exception: error,
          response: error is DioException ? error.response : null,
        ),
      );
    }
  }
}
