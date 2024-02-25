import 'package:currency_exchange/core/data/api_manager/models/response_model.dart';
import 'package:equatable/equatable.dart';

class ErrorException extends Equatable implements Exception {
  const ErrorException(this.statusCode, this.error);
  final int statusCode;
  final ResponseModel error;

  @override
  List<Object?> get props => [statusCode, error];
}
