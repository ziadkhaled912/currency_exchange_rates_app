import 'package:currency_exchange/features/auth/core/data/models/request/sign_up_request_model.dart';

class SignUpRequestModelMock {
  static const mockEmail = 'email@mail.com';
  static const mockPassword = 'password';
  static const mockName = 'name';
  static const invalidEmail = 'email';
  static const invalidPassword = '123';
  static const invalidName = 'n';

  static const mock = SignUpRequestModel(
    email: mockEmail,
    password: mockPassword,
    name: mockName,
  );
}
