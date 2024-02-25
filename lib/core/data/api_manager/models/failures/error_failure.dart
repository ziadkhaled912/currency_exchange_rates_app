import 'package:currency_exchange/core/data/api_manager/models/failures/failure.dart';
import 'package:currency_exchange/core/data/api_manager/models/response_model.dart';
import 'package:currency_exchange/core/data/api_manager/status_checker/error_status.dart';

class ErrorFailure extends Failure {
  ErrorFailure({required this.errorStatus, required this.error});
  final ErrorStatus errorStatus;
  final ResponseModel error;

  @override
  List<Object?> get props => [id, errorStatus, error];
}
