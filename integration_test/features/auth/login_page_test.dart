import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/core/helpers/app_faker.dart';
import 'package:currency_exchange/core/presentation/app.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/core/presentation/widgets/app_button.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model_mock.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/login/presentation/pages/login_page.dart';
import 'package:currency_exchange/features/auth/register/presentation/pages/register_page.dart';
import 'package:currency_exchange/features/home_base/presentation/home_base_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test/helpers/test_utils.dart';
import '../../../test/mock/data/login_request_model_mock.dart';

void main() {
  final loginPage = makeTestableWidget(
    child: const App(
      initialLocation: LoginPage.id,
    ),
    blocProvider: [
      BlocProvider<AuthCubit>.value(value: authCubit),
      BlocProvider<LanguageCubit>.value(value: languageCubit),
    ],
  );

  setUpAll(() {
    registerFallbackValue(LoginRequestModelMock.mock);
  });

  group('Login Page Form Fields Validation Test', () {
    setUpAll(() async {
      await initSignedOutUser();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is not logged in
      When user enters valid email and password
      Then submit button should be enabled
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(loginPage);
      await tester.pumpAndSettle();
      // Act
      await enterValidEmail(tester);
      await enterValidPassword(tester);
      // Assert
      assertValidForm(tester);
    });

    testWidgets('''
      Given user is not logged in
      When user enters invalid email
      Then should show error message
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(loginPage);
      await tester.pumpAndSettle();
      // Act
      await enterInValidEmail(tester);
      // Assert
      expect(find.text('Please Enter Valid Email'), findsOneWidget);
    });

    testWidgets('''
      Given user is not logged in
      When user enters invalid password
      Then should show error message
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(loginPage);
      await tester.pumpAndSettle();
      // Act
      await enterInValidPassword(tester);
      // Assert
      expect(find.text('Please Enter Your Password'), findsOneWidget);
    });

    testWidgets('''
      Given user is not logged in
      When user enters invalid email and password
      Then should show error messages and submit button should be disabled
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(loginPage);
      await tester.pumpAndSettle();
      // Act
      await enterInValidEmail(tester);
      await enterInValidPassword(tester);
      // Assert
      assertInValidForm(tester);
    });
  });

  group('LoginAction Test', () {
    setUpAll(() async {
      await initSignedOutUser();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is not logged in
      When user enters valid email and valid password
      Then press login button and repository returns success
      Then should navigate to HomeBasePage
    ''', (tester) async {
      await tester.runAsync(() async {
        // Arrange
        await tester.pumpWidget(loginPage);
        await tester.pumpAndSettle();
        await enterValidEmail(tester);
        await enterValidPassword(tester);
        when(() => authRepository.loginWithEmailAndPassword(any())).thenAnswer(
            (_) async => Future<void>.delayed(const Duration(milliseconds: 500))
                .then((_) => const Right(AuthUserModelMock.mockAuthUserModel)));
        // Act
        await pressLogin(tester);

        // Assert
        await assertLoading(tester);
        
        expect(find.byType(LoginPage), findsNothing);
        expect(find.byType(HomeBasePage), findsOneWidget);
      });
    });

    testWidgets('''
      Given user is not logged in
      When user enters valid email and valid password
      Then press login button and repository returns failure user not found
      Then should show error message 'Invalid Email or Password'
    ''', (tester) async {
      await tester.runAsync(() async {
        // Arrange
        await tester.pumpWidget(loginPage);
        await tester.pumpAndSettle();
        await enterValidEmail(tester);
        await enterValidPassword(tester);
        when(() => authRepository.loginWithEmailAndPassword(any())).thenAnswer(
            (_) async =>
                Future<void>.delayed(const Duration(milliseconds: 500)).then(
                  (_) => Left(
                    AuthFailure(
                        type: AuthFailureType.userNotFound,
                        errorMessage: 'Invalid Email'),
                  ),
                ));

        // Act
        await pressLogin(tester);

        // Assert
        await assertLoading(tester);

        await tester.pumpAndSettle();
        await tester.pump(); // Trigger the Snackbar animation

        expect(find.text('Invalid Email or Password'), findsOneWidget);
      });
    });
  });

  group('Register Navigation Test', () {
    setUpAll(() async {
      await initSignedOutUser();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is not logged in
      When user taps on register button
      Then should navigate to RegisterPage
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(loginPage);
      await tester.pumpAndSettle();
      // Act
      await tester.tap(find.byKey(const Key('goToRegisterButton')));
      await tester.pumpAndSettle();
      // Assert
      expect(find.byType(LoginPage), findsNothing);
      expect(find.byType(RegisterPage), findsOneWidget);
    });
  });
}

Future<void> enterValidEmail(WidgetTester tester) async {
  await tester.enterText(
      find.byKey(const Key('emailField')), LoginRequestModelMock.email);
  await tester.pumpAndSettle();
}

Future<void> enterInValidEmail(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('emailField')), AppFaker.word);
  await tester.pumpAndSettle();
}

Future<void> enterValidPassword(WidgetTester tester) async {
  await tester.enterText(
      find.byKey(const Key('passwordField')), LoginRequestModelMock.password);
  await tester.pumpAndSettle();
}

Future<void> enterInValidPassword(WidgetTester tester) async {
  await tester.enterText(find.byKey(const Key('passwordField')),
      LoginRequestModelMock.invalidPassword);
  await tester.pumpAndSettle();
}

void assertValidForm(WidgetTester tester) {
  expect(find.text('Please Enter Valid Email'), findsNothing);
  expect(find.text('Please Enter Your Password'), findsNothing);
  final loginButton =
      tester.widget<AppButton>(find.byKey(const Key('loginButton')));
  expect(loginButton.onPressed, isNotNull);
}

void assertInValidForm(WidgetTester tester) {
  expect(find.text('Please Enter Valid Email'), findsOneWidget);
  expect(find.text('Please Enter Your Password'), findsOneWidget);
  final loginButton =
      tester.widget<AppButton>(find.byKey(const Key('loginButton')));
  expect(loginButton.onPressed, isNull);
}

Future<void> pressLogin(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('loginButton')));
  final loginButton = find.byKey(const Key('loginButton'));
  await tester.tap(loginButton);
  // await tester.pumpAndSettle();
}

Future<void> assertLoading(WidgetTester tester) async {
  await tester.pump(Duration.zero);
  expect(find.byKey(const Key('ButtonLoadingIndicator')), findsOneWidget);
  await tester.pump(const Duration(milliseconds: 500));
  expect(find.byKey(const Key('ButtonLoadingIndicator')), findsNothing);
  await tester.pumpAndSettle();
}
