import 'package:currency_exchange/core/data/api_manager/api_manager.dart';

class RequestModelMock extends RequestModel {
  RequestModelMock({
    RequestProgressListener? progressListener,
    required this.data,
  }) : super(progressListener);

  final String data;

  @override
  List<Object?> get props => [data];

  @override
  Future<Map<String, dynamic>> toMap() async {
    return {"data": "data_mock"};
  }
}
