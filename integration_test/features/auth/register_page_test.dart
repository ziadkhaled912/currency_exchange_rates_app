import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/core/presentation/app.dart';
import 'package:currency_exchange/core/presentation/cubits/language_cubit/language_cubit.dart';
import 'package:currency_exchange/core/presentation/widgets/app_button.dart';
import 'package:currency_exchange/di/injection_container.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model_mock.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:currency_exchange/features/auth/register/presentation/pages/register_page.dart';
import 'package:currency_exchange/features/home_base/presentation/home_base_page.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../test/helpers/test_utils.dart';
import '../../../test/mock/data/sign_up_request_model_mock.dart';

void main() {
  final registerPage = makeTestableWidget(
    child: const App(initialLocation: RegisterPage.id),
    blocProvider: [
      BlocProvider<AuthCubit>.value(value: authCubit),
      BlocProvider<LanguageCubit>.value(value: languageCubit),
    ],
  );

  setUpAll(() {
    registerFallbackValue(SignUpRequestModelMock.mock);
  });

  group('RegisterPage Form Validation Test', () {
    setUpAll(() async {
      await initSignedOutUser();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is not logged in
      When user enters valid name, email and password
      Then submit button should be enabled
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(registerPage);
      await tester.pumpAndSettle();
      // Act
      await enterValidForm(tester);
      // Assert
      assertValidForm(tester);
    });

    testWidgets('''
      Given user is not logged in
      When user enters invalid name, email and password
      Then submit button should be disabled
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(registerPage);
      await tester.pumpAndSettle();
      // Act
      await enterInValidForm(tester);
      // Assert
      assertInValidForm(tester);
    });
  });

  group('RegisterPage Form Submission Test', () {
    setUpAll(() async {
      await initSignedOutUser();
    });

    tearDownAll(() async {
      await locator.reset();
    });

    testWidgets('''
      Given user is not logged in
      When user enters valid name, email and password
      And taps on submit button
      And Register API returns success
      Then should navigate to home page
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(registerPage);
      await tester.pumpAndSettle();
      await enterValidForm(tester);
      when(() => authRepository.signUpWithEmailAndPassword(any())).thenAnswer(
          (_) async => Future<void>.delayed(const Duration(milliseconds: 500))
              .then((_) => const Right(AuthUserModelMock.mockAuthUserModel)));
      // Act
      await pressSignUp(tester);

      await Future<void>.delayed(
            const Duration(milliseconds: 500)); // Simulate delay
      await tester.pumpAndSettle();
      // Assert
      expect(find.byType(RegisterPage), findsNothing);
      expect(find.byType(HomeBasePage), findsOneWidget);
    });

    testWidgets('''
      Given user is not logged in
      When user enters valid name, email and password
      And taps on submit button
      And Register API returns failure
      Then should show error message
    ''', (tester) async {
      // Arrange
      await tester.pumpWidget(registerPage);
      await tester.pumpAndSettle();
      await enterValidForm(tester);
      when(() => authRepository.signUpWithEmailAndPassword(any())).thenAnswer(
          (_) async =>
              Future<void>.delayed(const Duration(milliseconds: 500)).then(
                (_) => Left(
                  AuthFailure(
                    type: AuthFailureType.userAlreadyExists,
                    errorMessage: 'User Already Exists',
                  ),
                ),
              ));
      // Act
      await pressSignUp(tester);
      // Assert
      await Future<void>.delayed(
          const Duration(milliseconds: 500)); // Simulate delay

      await tester.pumpAndSettle();
      await tester.pump(); // Trigger the Snackbar animation

      expect(find.text('User Already Exists'), findsOneWidget);
    });
  });
}

Future<void> enterValidForm(WidgetTester tester) async {
  await tester.enterText(
      find.byKey(const Key('emailField')), SignUpRequestModelMock.mockEmail);
  await tester.enterText(find.byKey(const Key('passwordField')),
      SignUpRequestModelMock.mockPassword);
  await tester.enterText(
      find.byKey(const Key('nameField')), SignUpRequestModelMock.mockName);
  await tester.pumpAndSettle();
}

Future<void> enterInValidForm(WidgetTester tester) async {
  await tester.enterText(
      find.byKey(const Key('emailField')), SignUpRequestModelMock.invalidEmail);
  await tester.enterText(find.byKey(const Key('passwordField')),
      SignUpRequestModelMock.invalidPassword);
  await tester.enterText(
      find.byKey(const Key('nameField')), SignUpRequestModelMock.invalidName);
  await tester.pumpAndSettle();
}

void assertValidForm(WidgetTester tester) {
  expect(find.text('Please Enter Valid Email'), findsNothing);
  expect(find.text('Please Enter Valid Password'), findsNothing);
  expect(find.text('Please Enter Valid Name'), findsNothing);
  final signUpButton =
      tester.widget<AppButton>(find.byKey(const Key('signUpButton')));
  expect(signUpButton.onPressed, isNotNull);
}

void assertInValidForm(WidgetTester tester) {
  expect(find.text('Please Enter Valid Email'), findsOneWidget);
  expect(find.text('Please Enter Valid Password'), findsOneWidget);
  expect(find.text('Please Enter Valid Name'), findsOneWidget);
  final signUpButton =
      tester.widget<AppButton>(find.byKey(const Key('signUpButton')));
  expect(signUpButton.onPressed, isNull);
}

Future<void> pressSignUp(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('signUpButton')));

  final signUpButton = find.byKey(const Key('signUpButton'));
  await tester.tap(signUpButton);
}
