import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';

class AuthUserModelMock {
  static const mockUid = 'test_uid';
  static const mockEmail = 'test_email';
  static const mockName = 'test_name';
  static const mockPhotoURL = 'https://test.com/photo.jpg';

  static const mockAuthUserModel = AuthUserModel(
    id: mockUid,
    email: mockEmail,
    name: mockName,
    photoURL: mockPhotoURL,
  );
}
