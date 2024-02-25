import 'package:currency_exchange/core/data/api_manager/models/request/request_mixin.dart';
import 'package:dio/dio.dart';

class FailureInfo {
  FailureInfo({
    this.request,
    this.response,
    this.exception,
  });
  final Request? request;
  final Response<dynamic>? response;
  final dynamic exception;
}
