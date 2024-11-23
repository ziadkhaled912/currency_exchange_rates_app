import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/core/data/services/auth_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';
import '../../../../../mock/data/sign_up_request_model_mock.dart';
import '../../../faker.dart';

void main() {
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;
  late AuthServices authServices;
  late AuthUserModel authUserModel;

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();
    when(() => mockUser.uid).thenReturn(AuthUserModelMock.mockUid);
    when(() => mockUser.email).thenReturn(AuthUserModelMock.mockEmail);
    when(() => mockUser.displayName).thenReturn(AuthUserModelMock.mockName);
    when(() => mockUser.photoURL).thenReturn(AuthUserModelMock.mockPhotoURL);
    authServices = AuthServicesImpl(firebaseAuth: mockFirebaseAuth);
    authUserModel = AuthUserModel.fromFirebaseAuthUser(mockUser);
  });

  group('signUpWithEmailAndPassword', () {
    test('should return AuthUserModel when sign up success', () async {
      // Arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.updateDisplayName(any())).thenAnswer((_) async {});

      // Act
      final result = await authServices.signUpWithEmailAndPassword(
        AuthUserModelMock.mockEmail,
        SignUpRequestModelMock.mockPassword,
        AuthUserModelMock.mockName,
      );

      // Assert
      expect(result, authUserModel);
    });

    test('should throw Exception when sign up failed', () async {
      // Arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception());

      // Act
      final call = authServices.signUpWithEmailAndPassword(
        AuthUserModelMock.mockEmail,
        SignUpRequestModelMock.mockPassword,
        AuthUserModelMock.mockName,
      );

      // Assert
      expect(() => call, throwsException);
    });

    test('should throw Exception when update display name failed', () async {
      // Arrange
      when(() => mockFirebaseAuth.createUserWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);
      when(() => mockUser.updateDisplayName(any())).thenThrow(Exception());

      // Act
      final call = authServices.signUpWithEmailAndPassword(
        AuthUserModelMock.mockEmail,
        SignUpRequestModelMock.mockPassword,
        AuthUserModelMock.mockName,
      );

      // Assert
      expect(() => call, throwsException);
    });
  });

  group('signInWithEmailAndPassword', () {
    test('should return AuthUserModel when sign in success', () async {
      // Arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => mockUserCredential);
      when(() => mockUserCredential.user).thenReturn(mockUser);

      // Act
      final result = await authServices.loginWithEmailAndPassword(
        AuthUserModelMock.mockEmail,
        SignUpRequestModelMock.mockPassword,
      );

      // Assert
      expect(result, authUserModel);
    });

    test('should throw Exception when sign in failed', () async {
      // Arrange
      when(() => mockFirebaseAuth.signInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenThrow(Exception());

      // Act
      final call = authServices.loginWithEmailAndPassword(
        AuthUserModelMock.mockEmail,
        SignUpRequestModelMock.mockPassword,
      );

      // Assert
      expect(() => call, throwsException);
    });
  });

  group('signOut', () {
    test('should return void when sign out success', () async {
      // Arrange
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      // Act
      await authServices.logout();

      // Assert
      verify(() => mockFirebaseAuth.signOut());
    });

    test('should throw Exception when sign out failed', () async {
      // Arrange
      when(() => mockFirebaseAuth.signOut()).thenThrow(Exception());

      // Act
      final call = authServices.logout();

      // Assert
      expect(() => call, throwsException);
    });
  });

  group('currentUser', () {
    test('should return AuthUserModel when user is not null', () {
      // Arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(mockUser);

      // Act
      final result = authServices.currentUser;

      // Assert
      expect(result, authUserModel);
    });

    test('should return null when user is null', () {
      // Arrange
      when(() => mockFirebaseAuth.currentUser).thenReturn(null);

      // Act
      final result = authServices.currentUser;

      // Assert
      expect(result, null);
    });
  });

  group('logout', () {
    test('should return void when sign out success', () async {
      // Arrange
      when(() => mockFirebaseAuth.signOut()).thenAnswer((_) async {});

      // Act
      await authServices.logout();

      // Assert
      verify(() => mockFirebaseAuth.signOut());
    });

    test('should throw Exception when sign out failed', () async {
      // Arrange
      when(() => mockFirebaseAuth.signOut()).thenThrow(Exception());

      // Act
      final call = authServices.logout();

      // Assert
      expect(() => call, throwsException);
    });
  });

}
