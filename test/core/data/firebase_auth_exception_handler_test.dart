import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/core/data/firebase_auth_exception_handler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FirebaseAuthExceptionHandler AuthFailureType Tests', () {
    test('AuthFailureType.invalidEmail', () {
      final exception = FirebaseAuthException(
        code: 'invalid-email',
        message: 'Invalid email',
      );
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
            type: AuthFailureType.invalidEmail,
            errorMessage: 'Invalid email',
          ));
    });

    test('AuthFailureType.userAlreadyExists', () {
      final exception = FirebaseAuthException(
        code: 'email-already-exists',
        message: 'Email already exists',
      );
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
            type: AuthFailureType.userAlreadyExists,
            errorMessage: 'Email already exists',
          ));
    });

    test('AuthFailureType.internalError', () {
      final exception = FirebaseAuthException(
          code: 'internal-error', message: 'Internal error');
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
              type: AuthFailureType.internalError,
              errorMessage: 'Internal error'));
    });

    test('AuthFailureType.wrongPassword', () {
      final exception = FirebaseAuthException(
          code: 'invalid-password', message: 'Invalid password');
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
              type: AuthFailureType.wrongPassword,
              errorMessage: 'Invalid password'));
    });

    test('AuthFailureType.userNotFound', () {
      final exception = FirebaseAuthException(
          code: 'user-not-found', message: 'User not found');
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
              type: AuthFailureType.userNotFound,
              errorMessage: 'User not found'));
    });

    test('AuthFailureType.userNotFound', () {
      final exception = FirebaseAuthException(
          code: 'invalid-credential', message: 'User not found');
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
              type: AuthFailureType.userNotFound,
              errorMessage: 'User not found'));
    });

    test('AuthFailureType.operationNotAllowed', () {
      final exception = FirebaseAuthException(
          code: 'operation-not-allowed', message: 'Operation not allowed');
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
              type: AuthFailureType.operationNotAllowed,
              errorMessage: 'Operation not allowed'));
    });

    test('AuthFailureType.unknown', () {
      final exception =
          FirebaseAuthException(code: 'unknown', message: 'Unknown error');
      final failure = FirebaseAuthHandler().handle(exception);
      expect(
          failure,
          AuthFailure(
              type: AuthFailureType.unknown, errorMessage: 'Unknown error'));
    });
  });

  test('UnknownFailure', () {
    final exception = Exception();
    final failure = FirebaseAuthHandler().handle(exception);
    expect(failure, UnknownFailure(FailureInfo(exception: exception)));
  });
}
