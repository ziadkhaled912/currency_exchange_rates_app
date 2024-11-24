import 'package:currency_exchange/core/data/api_manager/api_manager.dart';

enum AuthFailureType {
  invalidEmail,
  userNotFound,
  wrongPassword,
  userAlreadyExists,
  internalError,
  operationNotAllowed,
  unknown,
}

class AuthFailure extends Failure {
  AuthFailure({
    required this.type,
    required this.errorMessage,
  });

  final AuthFailureType type;
  final String errorMessage;

  @override
  List<Object?> get props => [type, errorMessage];
}
