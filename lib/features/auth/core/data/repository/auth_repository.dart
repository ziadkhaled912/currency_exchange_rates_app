import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/auth_failure.dart';
import 'package:currency_exchange/core/data/firebase_auth_exception_handler.dart';
import 'package:currency_exchange/features/auth/core/data/models/request/login_in_request_model.dart';
import 'package:currency_exchange/features/auth/core/data/models/request/sign_up_request_model.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/core/data/services/auth_services.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthUserModel>> loginWithEmailAndPassword(
      LoginRequestModel request);

  Future<Either<Failure, AuthUserModel>> signUpWithEmailAndPassword(
      SignUpRequestModel request);

  Future<void> logout();

  AuthUserModel? get currentUser; 
}

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._authServices);

  final AuthServices _authServices;
  final FirebaseAuthHandler _firebaseAuthHandler = FirebaseAuthHandler();

  @override
  Future<Either<Failure, AuthUserModel>> loginWithEmailAndPassword(
      LoginRequestModel request) async {
    try {
      final result = await _authServices.loginWithEmailAndPassword(
        request.email,
        request.password,
      );
      if (result != null) {
        return Right(result);
      }
      return Left(AuthFailure(
        type: AuthFailureType.unknown,
        errorMessage: 'Unknown error',
      ));
    } on Exception catch (e) {
      return Left(_firebaseAuthHandler.handle(e));
    }
  }

  @override
  Future<Either<Failure, AuthUserModel>> signUpWithEmailAndPassword(
      SignUpRequestModel request) async {
    try {
      final result = await _authServices.signUpWithEmailAndPassword(
        request.email,
        request.password,
        request.name,
      );
      if (result != null) {
        return Right(result);
      }
      return Left(AuthFailure(
        type: AuthFailureType.unknown,
        errorMessage: 'Unknown error',
      ));
    } on Exception catch (e) {
      return Left(_firebaseAuthHandler.handle(e));
    }
  }

  @override
  Future<void> logout() async {
    await _authServices.logout();
  }

  @override
  AuthUserModel? get currentUser => _authServices.currentUser;
}
