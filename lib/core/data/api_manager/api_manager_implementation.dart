import 'package:currency_exchange/core/helpers/dio2curl.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import 'api_manager.dart';

@lazySingleton
class APIsManager {
  APIsManager(this._dio);

  final StatusChecker _statusChecker = StatusChecker();
  final FailureHandler _failureHandler = FailureHandler();
  final Dio _dio;
  // final List<Interceptor> interceptors;

  Future<Either<Failure, R>> send<R, ER extends ResponseModel>({
    required Request request,
    required R Function(Map<String, dynamic> map) responseFromMap,
    ER Function(Map<String, dynamic> map)? errorResponseFromMap,
  }) async {
    Response<dynamic>? response;
    try {
      response = await _dio.request(
        request.url,
        data: await request.data,
        queryParameters: await request.queryParameters,
        cancelToken: request.cancelToken,
        onSendProgress: request.requestModel.progressListener?.onSendProgress,
        onReceiveProgress:
            request.requestModel.progressListener?.onReceiveProgress,
        options: Options(
          headers: request.headers,
          method: request.method,
        ),
      );
      dio2curl(response.requestOptions);
      if (response.data! is Map<String, dynamic>) {
        return Right(responseFromMap(response.data as Map<String, dynamic>));
      } else if (response.data is String) {
        return Right(responseFromMap({'msg': response.data}));
      } else if (response.data is List && (response.data as List).isNotEmpty) {
        return Right(responseFromMap({'list': response.data}));
      } else {
        return Right(responseFromMap({'msg': response.data.toString()}));
      }
    } on DioException catch (error) {
      dio2curl(error.response?.requestOptions);
      if (error.type == DioExceptionType.badResponse) {
        if (error.response?.statusCode != null &&
            _statusChecker(error.response!.statusCode) == HTTPCodes.error) {
          try {
            var errorData = <String, dynamic>{};
            errorData = error.response!.data is Map<String, dynamic>
                ? error.response!.data as Map<String, dynamic>
                : {"msg": error.response!.data};
            final exception = ErrorException(
              error.response!.statusCode!,
              errorResponseFromMap != null
                  ? errorResponseFromMap(errorData)
                  : MessageResponseModel.fromMap(errorData),
            );

            return Left(
              _failureHandler.handle(
                request: request,
                exception: exception,
                response: error.response,
              ),
            );
          } on Exception catch (exception) {
            return Left(
              _failureHandler.handle(
                request: request,
                exception: exception,
                response: response,
              ),
            );
          }
        } else {
          final exception = ServerException(error.response);

          return Left(
            _failureHandler.handle(
              request: request,
              exception: exception,
              response: error.response,
            ),
          );
        }
      }

      return Left(
        _failureHandler.handle(
          request: request,
          exception: error,
          response: error.response,
        ),
      );
    } catch (exception) {
      dio2curl(response?.requestOptions);

      return Left(
        _failureHandler.handle(
          request: request,
          exception: exception,
          response: response,
        ),
      );
    }
  }
}
