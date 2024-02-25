import 'package:currency_exchange/core/data/api_manager/api_manager.dart';

class GetRequestMock with Request, GetRequest {
  GetRequestMock(this.requestModel);

  @override
  final RequestModel requestModel;

  @override
  String get path => "path";
}
