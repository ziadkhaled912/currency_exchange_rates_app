import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_response_model.dart';
import 'package:currency_exchange/features/gold_rates/data/requests/gold_price_request.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoldRepository {
  GoldRepository(this._apIsManager);

  final APIsManager _apIsManager;

  Future<Either<Failure, GoldPriceResponseModel>> getGoldPrices(
    GoldPriceRequestModel requestModel,
  ) async {
    final result = await _apIsManager.send(
      request: GoldPriceRequest(requestModel),
      responseFromMap: GoldPriceResponseModel.fromMap,
    );
    return result;
  }
}
