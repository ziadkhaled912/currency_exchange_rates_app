import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';

class GoldPriceRequest with Request, GetRequest {
  GoldPriceRequest(this.requestModel);

  @override
  String get path => '/XAU/EGP${requestModel.date != null ? "/${requestModel.date}" : ''}';

  @override
  final GoldPriceRequestModel requestModel;

  @override
  String get baseUrl => 'https://www.goldapi.io/api';
}
