import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/register/presentation/cubit/register_cubit.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';
import '../../../mock/data/sign_up_request_model_mock.dart';
import '../../../mock/repository/mock_auth_repository.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late RegisterCubit registerCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    registerCubit = RegisterCubit(mockAuthRepository);
  });

  test('initial state loading should be false and failure, user should be null',
      () {
    expect(registerCubit.state, const RegisterState());
  });

  group('onEmailChanged', () {
    blocTest<RegisterCubit, RegisterState>(
      'should emit state with entered email',
      build: () => registerCubit,
      act: (cubit) => cubit..onEmailChanged(SignUpRequestModelMock.mockEmail),
      expect: () => [
        const RegisterState(email: SignUpRequestModelMock.mockEmail),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      'should emit state with isFormValid false if entered wrong email',
      build: () => registerCubit,
      act: (cubit) =>
          cubit..onEmailChanged(SignUpRequestModelMock.invalidEmail),
      expect: () => [
        const RegisterState(email: SignUpRequestModelMock.invalidEmail),
      ],
      verify: (_) {
        expect(registerCubit.state.isFormValid, false);
      },
    );
  });

  group('onPasswordChanged', () {
    blocTest<RegisterCubit, RegisterState>(
      'should emit state with entered password',
      build: () => registerCubit,
      act: (cubit) =>
          cubit..onPasswordChanged(SignUpRequestModelMock.mockPassword),
      expect: () => [
        const RegisterState(password: SignUpRequestModelMock.mockPassword),
      ],
    );
  });

  group('onNameChanged', () {
    blocTest<RegisterCubit, RegisterState>(
      'should emit state with entered name',
      build: () => registerCubit,
      act: (cubit) =>
          cubit..onNameChanged(SignUpRequestModelMock.mockName),
      expect: () => [
        const RegisterState(name: SignUpRequestModelMock.mockName),
      ],
    );
  });

  group('toggleObscure', () {
    blocTest<RegisterCubit, RegisterState>(
      'should emit state with isObscure false',
      build: () => registerCubit,
      act: (cubit) => cubit..toggleObscure(),
      expect: () => [
        const RegisterState(isObscure: false),
      ],
    );
  });

  group('registerWithEmailAndPassword', () {
    blocTest<RegisterCubit, RegisterState>(
      '''should emit state with userRegister when signUpWithEmailAndPassword is successful''',
      build: () => registerCubit,
      setUp: () {
        when(() => mockAuthRepository
                .signUpWithEmailAndPassword(SignUpRequestModelMock.mock))
            .thenAnswer(
                (_) async => const Right(AuthUserModelMock.mockAuthUserModel));
      },
      act: (cubit) => cubit
        ..onEmailChanged(SignUpRequestModelMock.mockEmail)
        ..onNameChanged(SignUpRequestModelMock.mockName)
        ..onPasswordChanged(SignUpRequestModelMock.mockPassword)
        ..registerWithEmailAndPassword(),
      expect: () => [
        const RegisterState(
          email: SignUpRequestModelMock.mockEmail,
        ),
        const RegisterState(
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
        ),
        const RegisterState(
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
          password: SignUpRequestModelMock.mockPassword,
        ),
        const RegisterState(
          isLoading: true,
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
          password: SignUpRequestModelMock.mockPassword,
        ),
        const RegisterState(
          user: AuthUserModelMock.mockAuthUserModel,
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
          password: SignUpRequestModelMock.mockPassword,
        ),
      ],
    );

    blocTest<RegisterCubit, RegisterState>(
      '''should emit state with [loading, error] when signUpWithEmailAndPassword is unsuccessful''',
      build: () => registerCubit,
      setUp: () {
        when(() => mockAuthRepository
                .signUpWithEmailAndPassword(SignUpRequestModelMock.mock))
            .thenAnswer((_) async => Left<Failure, AuthUserModel>(AuthFailure(
                  type: AuthFailureType.unknown,
                  errorMessage: 'Unknown error',
                )));
      },
      act: (cubit) => cubit
        ..onEmailChanged(SignUpRequestModelMock.mockEmail)
        ..onNameChanged(SignUpRequestModelMock.mockName)
        ..onPasswordChanged(SignUpRequestModelMock.mockPassword)
        ..registerWithEmailAndPassword(),
      expect: () => [
        const RegisterState(
          email: SignUpRequestModelMock.mockEmail,
        ),
        const RegisterState(
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
        ),
        const RegisterState(
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
          password: SignUpRequestModelMock.mockPassword,
        ),
        const RegisterState(
          isLoading: true,
          email: SignUpRequestModelMock.mockEmail,
          name: SignUpRequestModelMock.mockName,
          password: SignUpRequestModelMock.mockPassword,
        ),
        RegisterState(
          failure: AuthFailure(
            type: AuthFailureType.unknown,
            errorMessage: 'Unknown error',
          ),
          email: SignUpRequestModelMock.mockEmail,
          password: SignUpRequestModelMock.mockPassword,
          name: SignUpRequestModelMock.mockName,
        ),
      ],
    );
  });
}
