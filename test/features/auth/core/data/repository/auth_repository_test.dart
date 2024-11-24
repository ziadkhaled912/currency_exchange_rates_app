import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/core/data/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';
import '../../../../../mock/data/login_request_model_mock.dart';
import '../../../../../mock/services/mock_auth_services.dart';
import '../../../faker.dart';

void main() {
  late MockAuthServices mockAuthServices;
  late AuthRepository authRepository;

  setUp(() {
    mockAuthServices = MockAuthServices();
    authRepository = AuthRepositoryImpl(mockAuthServices);
  });

  group('loginWithEmailAndPassword', () {
    test(
        '''should return AuthUserModel when loginWithEmailAndPassword is successful''',
        () async {
      // arrange
      when(() => mockAuthServices.loginWithEmailAndPassword(any(), any()))
          .thenAnswer((_) async => AuthUserModelMock.mockAuthUserModel);
      // act
      final result = await authRepository
          .loginWithEmailAndPassword(LoginRequestModelMock.mock);
      // assert
      expect(
          result,
          const Right<Failure, AuthUserModel>(
              AuthUserModelMock.mockAuthUserModel));
    });

    test(
        '''should return AuthFailure when loginWithEmailAndPassword is unsuccessful''',
        () async {
      final failure = AuthFailure(
        type: AuthFailureType.unknown,
        errorMessage: 'Unknown error',
      );
      // arrange
      when(() => mockAuthServices.loginWithEmailAndPassword(any(), any()))
          .thenThrow(FirebaseAuthException(
        code: 'unknown',
        message: 'Unknown error',
      ));
      // act
      final result = await authRepository
          .loginWithEmailAndPassword(LoginRequestModelMock.mock);
      // assert
      expect(result, Left<Failure, AuthUserModel>(failure));
    });

    test(
        '''should return AuthFailure when loginWithEmailAndPassword is unsuccessful with invalid email''',
        () async {
      final failure = AuthFailure(
        type: AuthFailureType.invalidEmail,
        errorMessage: 'Invalid email',
      );
      // arrange
      when(() => mockAuthServices.loginWithEmailAndPassword(any(), any()))
          .thenThrow(FirebaseAuthException(
        code: 'invalid-email',
        message: 'Invalid email',
      ));
      // act
      final result = await authRepository
          .loginWithEmailAndPassword(LoginRequestModelMock.mock);
      // assert
      expect(result, Left<Failure, AuthUserModel>(failure));
    });

    test(
        '''should return UnknownFailure when loginWithEmailAndPassword throw exception''',
        () async {
      final exception = Exception();
      final failure = UnknownFailure(FailureInfo(exception: exception));
      // arrange
      when(() => mockAuthServices.loginWithEmailAndPassword(any(), any()))
          .thenThrow(exception);
      // act
      final result = await authRepository
          .loginWithEmailAndPassword(LoginRequestModelMock.mock);
      // assert
      expect(result, Left<Failure, AuthUserModel>(failure));
    });
  });
}
