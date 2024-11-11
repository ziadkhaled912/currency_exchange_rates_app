import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_request_model.dart';
import 'package:currency_exchange/features/gold_rates/data/models/gold_price_response_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GoldRatesApiServices {
  GoldRatesApiServices(this._dio);

  final Dio _dio;

  final StatusChecker _statusChecker = StatusChecker();

  Future<GoldPriceResponseModel> getGoldRates(
    GoldPriceRequestModel requestModel,
  ) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        'https://www.goldapi.io/api/XAU/EGP${requestModel.date != null ? "/${requestModel.date}" : ''}',
      );
      return GoldPriceResponseModel.fromMap(response.data!);
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
