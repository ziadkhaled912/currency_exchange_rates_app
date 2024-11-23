import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthHandler {
  FirebaseAuthHandler();

  Failure handle(Exception exception) {
    final failureInfo = FailureInfo(
      exception: exception,
    );
    Failure? failure;
    if (exception is FirebaseAuthException) {
      if (exception.code == 'invalid-email') {
        return AuthFailure(
          type: AuthFailureType.invalidEmail,
          errorMessage: exception.message ?? 'Invalid email',
        );
      } else if (exception.code == 'email-already-exists') {
        return AuthFailure(
          type: AuthFailureType.userAlreadyExists,
          errorMessage: exception.message ?? 'Email already exists',
        );
      } else if (exception.code == 'internal-error') {
        return AuthFailure(
          type: AuthFailureType.internalError,
          errorMessage: exception.message ?? 'Internal error',
        );
      } else if (exception.code == 'invalid-password') {
        return AuthFailure(
          type: AuthFailureType.wrongPassword,
          errorMessage: exception.message ?? 'Invalid password',
        );
      } else if (exception.code == 'user-not-found' ||
          exception.code == 'invalid-credential') {
        return AuthFailure(
          type: AuthFailureType.userNotFound,
          errorMessage: exception.message ?? 'User not found',
        );
      } else if (exception.code == 'operation-not-allowed') {
        return AuthFailure(
          type: AuthFailureType.operationNotAllowed,
          errorMessage: exception.message ?? 'Operation not allowed',
        );
      } else {
        return AuthFailure(
          type: AuthFailureType.unknown,
          errorMessage: exception.message ?? 'Unknown error',
        );
      }
    }
    return failure ?? UnknownFailure(failureInfo);
  }
}
