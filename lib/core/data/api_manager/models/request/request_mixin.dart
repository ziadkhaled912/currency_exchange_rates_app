import 'package:currency_exchange/core/data/api_manager/models/request/base_request.dart';
import 'package:currency_exchange/core/data/api_manager/models/request/base_request_defaults.dart';
import 'package:dio/dio.dart';

mixin Request implements BaseRequest {
  String get baseUrl => BaseRequestDefaults.instance.baseUrl;

  String get url => baseUrl + path;

  CancelToken get cancelToken => requestModel.cancelToken;

  bool get includeAuthorization => true;

  bool get multiPart => false;

  Map<String, String>? get headers {
    final headers = BaseRequestDefaults.instance.header;

    if (BaseRequestDefaults.instance.token.isNotEmpty && includeAuthorization) {
      headers.addAll(BaseRequestDefaults.instance.token);
    }

    return headers;
  }
}
