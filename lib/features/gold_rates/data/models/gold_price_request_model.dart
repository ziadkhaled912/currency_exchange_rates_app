import 'package:currency_exchange/core/data/api_manager/api_manager.dart';

class GoldPriceRequestModel extends RequestModel {
  GoldPriceRequestModel({
    this.date,
    RequestProgressListener? progressListener,
  }) : super(progressListener);

  final String? date;

  @override
  List<Object?> get props => [date];

  @override
  Future<Map<String, dynamic>> toMap() async {
    final map = <String, dynamic>{};
    if (date != null) map['date'] = date;

    return map;
  }
}
