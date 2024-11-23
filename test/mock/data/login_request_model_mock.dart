import 'package:currency_exchange/core/helpers/app_faker.dart';
import 'package:currency_exchange/features/auth/core/data/models/request/login_in_request_model.dart';

class LoginRequestModelMock {
  static const password = 'password';
  static const email = 'email@mail.com';
  static const invalidEmail = 'email';
  static const invalidPassword = '123';


  static const mock = LoginRequestModel(
    email: email,
    password: password,
  );

  static const mockInvalidEmail = LoginRequestModel(
    email: invalidEmail,
    password: password,
  ); 

  static const mockInvalidPassword = LoginRequestModel(
    email: email,
    password: '',
  );

  static LoginRequestModel get random => LoginRequestModel(
    email: AppFaker.email,
    password: AppFaker.word,
  );
}
