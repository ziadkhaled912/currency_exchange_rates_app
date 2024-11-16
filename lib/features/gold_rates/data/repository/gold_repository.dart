import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_response_model.dart';
import 'package:currency_exchange/features/gold_rates/data/services/gold_rates_api_services.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoldRepository {
  GoldRepository(this._apiServices);

  final GoldRatesApiServices _apiServices;

  final FailureHandler _failureHandler = FailureHandler();

  Future<Either<Failure, GoldPriceResponseModel>> getGoldPrices(
    GoldPriceRequestModel requestModel,
  ) async {
    try {
      final response = await _apiServices.getGoldRates(requestModel);
      return Right(response);
    } on Exception catch (e) {
      return Left(
        _failureHandler.handle(
          exception: e,
          response: e is DioException ? e.response : null,
        ),
      );
    }
  }
}
