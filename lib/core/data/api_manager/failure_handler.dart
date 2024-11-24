import 'dart:io';

import 'package:dio/dio.dart';

import 'api_manager.dart';

class FailureHandler {
  FailureHandler();
  final StatusChecker _statusChecker = StatusChecker();

  Failure handle({
    dynamic exception,
    Response<dynamic>? response,
  }) {
    final failureInfo = FailureInfo(
      exception: exception,
      response: response,
    );
    Failure? failure;
    if (exception is ErrorException) {
      failure = ErrorFailure(
        errorStatus: _statusChecker.getErrorState(exception.statusCode),
        error: exception.error,
      );
    } else if (exception is DioException) {
      switch (exception.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionError:
          failure = ConnectionFailure();
          break;
        case DioExceptionType.cancel:
        case DioExceptionType.badResponse:
        case DioExceptionType.badCertificate:
        case DioExceptionType.unknown:
          failure = UnknownFailure(failureInfo);
          break;
      }
    } else if (exception is ServerException) {
      final status = _statusChecker(exception.response?.statusCode);
      switch (status) {
        case HTTPCodes.unknown:
          failure = UnknownFailure(failureInfo);
          break;
        case HTTPCodes.success:
        case HTTPCodes.error:
          break;
      }
    } else if (exception is SocketException) {
      failure = ConnectionFailure();
    }

    return failure ?? UnknownFailure(failureInfo);
  }
}
