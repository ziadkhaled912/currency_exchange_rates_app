import 'package:currency_exchange/core/data/api_manager/api_manager.dart';

class PostRequestMock with Request, PostRequest {
  PostRequestMock(this.requestModel);

  @override
  final RequestModel requestModel;

  @override
  bool get multiPart => true;

  @override
  String get path => "path";
}
