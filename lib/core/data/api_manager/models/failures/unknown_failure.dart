import 'package:currency_exchange/core/data/api_manager/api_manager.dart';

class UnknownFailure extends Failure {
  UnknownFailure(
    this.failureInfo, {
    this.type = '',
  });

  final FailureInfo failureInfo;
  final String type;
}
