import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/home/data/models/request_models/latest_rates_request_model.dart';

class LatestRatesRequest with Request, GetRequest {
  LatestRatesRequest(this.requestModel);

  @override
  String get path => "/v3/latest";

  @override
  final LatestRatesRequestModel requestModel;
}
