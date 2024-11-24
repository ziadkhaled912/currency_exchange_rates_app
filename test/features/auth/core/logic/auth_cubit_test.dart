import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';
import '../../../../mock/repository/mock_auth_repository.dart';
import '../../faker.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthCubit authCubit;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    authCubit = AuthCubit(mockAuthRepository);
  });

  test('initial state user should be null and isAuthenticated should be false',
      () {
    expect(authCubit.state, const AuthState());
    expect(authCubit.state.isAuthenticated, false);
  });

  group('getCurrentUser', () {
    blocTest<AuthCubit, AuthState>(
      'should emit state with current user',
      build: () => authCubit,
      setUp: () => when(() => mockAuthRepository.currentUser)
          .thenReturn(AuthUserModelMock.mockAuthUserModel),
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [
        const AuthState(currentUser: AuthUserModelMock.mockAuthUserModel),
      ],
      verify: (cubit) {
        expect(cubit.state.isAuthenticated, true);
      },
    );

    blocTest<AuthCubit, AuthState>(
      'should emit state with current user as null',
      build: () => authCubit,
      setUp: () => when(() => mockAuthRepository.currentUser).thenReturn(null),
      act: (cubit) => cubit.getCurrentUser(),
      expect: () => [
        const AuthState(),
      ],
      verify: (cubit) {
        expect(cubit.state.isAuthenticated, false);
      },
    );
  });

  group('logout', () {
    blocTest<AuthCubit, AuthState>(
      '''
should emit state with current user as null
and isAuthenticated as false
''',
      build: () => authCubit,
      act: (cubit) => cubit.logout(),
      setUp: () =>
          when(() => mockAuthRepository.logout()).thenAnswer((_) async {
        return;
      }),
      seed: () =>
          const AuthState(currentUser: AuthUserModelMock.mockAuthUserModel),
      expect: () => [
        const AuthState(),
      ],
      verify: (cubit) {
        expect(cubit.state.isAuthenticated, false);
      },
    );
  });
}
