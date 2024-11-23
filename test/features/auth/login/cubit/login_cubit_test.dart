import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/login/presentation/cubit/login_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';
import '../../../../mock/data/login_request_model_mock.dart';
import '../../../../mock/repository/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late LoginCubit loginCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    loginCubit = LoginCubit(mockAuthRepository);
  });

  test('initial state loading should be false and failure, user should be null',
      () {
    expect(loginCubit.state, const LoginState());
  });

  group('onEmailChanged', () {
    blocTest<LoginCubit, LoginState>(
      'should emit state with entered email',
      build: () => loginCubit,
      act: (cubit) => cubit..onEmailChanged(LoginRequestModelMock.email),
      expect: () => [
        const LoginState(email: LoginRequestModelMock.email),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      'should emit state with isFormValid false if entered wrong email',
      build: () => loginCubit,
      act: (cubit) => cubit..onEmailChanged(LoginRequestModelMock.invalidEmail),
      expect: () => [
        const LoginState(email: LoginRequestModelMock.invalidEmail),
      ],
      verify: (_) {
        expect(loginCubit.state.isFormValid, false);
      },
    );
  });

  group('onPasswordChanged', () {
    blocTest<LoginCubit, LoginState>(
      'should emit state with entered password',
      build: () => loginCubit,
      act: (cubit) => cubit..onPasswordChanged(LoginRequestModelMock.password),
      expect: () => [
        const LoginState(password: LoginRequestModelMock.password),
      ],
    );
  });

  group('toggleObscure', () {
    blocTest<LoginCubit, LoginState>(
      'should emit state with isObscure false',
      build: () => loginCubit,
      act: (cubit) => cubit..toggleObscure(),
      expect: () => [
        const LoginState(isObscure: false),
      ],
    );
  });

  group('loginWithEmailAndPassword', () {
    blocTest<LoginCubit, LoginState>(
      '''should emit state with userLoggedIn when loginWithEmailAndPassword is successful''',
      build: () => loginCubit,
      setUp: () {
        when(() => mockAuthRepository
                .loginWithEmailAndPassword(LoginRequestModelMock.mock))
            .thenAnswer(
                (_) async => const Right(AuthUserModelMock.mockAuthUserModel));
      },
      act: (cubit) => cubit
        ..onEmailChanged(LoginRequestModelMock.email)
        ..onPasswordChanged(LoginRequestModelMock.password)
        ..loginWithEmailAndPassword(),
      expect: () => [
        const LoginState(
          email: LoginRequestModelMock.email,
        ),
        const LoginState(
          email: LoginRequestModelMock.email,
          password: LoginRequestModelMock.password,
        ),
        const LoginState(
          isLoading: true,
          email: LoginRequestModelMock.email,
          password: LoginRequestModelMock.password,
        ),
        const LoginState(
          user: AuthUserModelMock.mockAuthUserModel,
          email: LoginRequestModelMock.email,
          password: LoginRequestModelMock.password,
        ),
      ],
    );

    blocTest<LoginCubit, LoginState>(
      '''should emit state with [loading, error] when loginWithEmailAndPassword is unsuccessful''',
      build: () => loginCubit,
      setUp: () {
        when(() => mockAuthRepository
                .loginWithEmailAndPassword(LoginRequestModelMock.mock))
            .thenAnswer((_) async => Left<Failure, AuthUserModel>(AuthFailure(
                  type: AuthFailureType.unknown,
                  errorMessage: 'Unknown error',
                )));
      },
      act: (cubit) => cubit
        ..onEmailChanged(LoginRequestModelMock.email)
        ..onPasswordChanged(LoginRequestModelMock.password)
        ..loginWithEmailAndPassword(),
      expect: () => [
        const LoginState(
          email: LoginRequestModelMock.email,
        ),
        const LoginState(
          email: LoginRequestModelMock.email,
          password: LoginRequestModelMock.password,
        ),
        const LoginState(
          isLoading: true,
          email: LoginRequestModelMock.email,
          password: LoginRequestModelMock.password,
        ),
        LoginState(
          failure: AuthFailure(
            type: AuthFailureType.unknown,
            errorMessage: 'Unknown error',
          ),
          email: LoginRequestModelMock.email,
          password: LoginRequestModelMock.password,
        ),
      ],
    );
  });
}
