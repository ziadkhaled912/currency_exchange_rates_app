import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';
import 'package:currency_exchange/features/home/data/models/response_models/latest_rates_response_model.dart';
import 'package:currency_exchange/features/home/data/requests/latest_rates_request.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CurrencyRepository {
  CurrencyRepository(this._apIsManager);

  final APIsManager _apIsManager;

  Future<Either<Failure, LatestRatesResponseModel>> getLatestRates(
    LatestRatesRequestModel requestModel,
  ) async {
    final result =
        await _apIsManager.send<LatestRatesResponseModel, MessageResponseModel>(
      request: LatestRatesRequest(requestModel),
      responseFromMap: LatestRatesResponseModel.fromMap,
    );
    return result;
  }
}
