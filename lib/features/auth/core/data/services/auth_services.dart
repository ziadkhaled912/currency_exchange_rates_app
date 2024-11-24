import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

abstract class AuthServices {
  AuthUserModel? get currentUser;

  Future<AuthUserModel?> loginWithEmailAndPassword(
      String email, String password);

  Future<AuthUserModel?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  );

  Future<void> logout();
}

@LazySingleton(as: AuthServices)
class AuthServicesImpl implements AuthServices {
  AuthServicesImpl({@ignoreParam FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<AuthUserModel?> loginWithEmailAndPassword(
      String email, String password) async {
    final userAuth = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userAuth.user != null) {
      return AuthUserModel.fromFirebaseAuthUser(userAuth.user!);
    }
    return null;
  }

  @override
  Future<AuthUserModel?> signUpWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    final userAuth = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    await userAuth.user!.updateDisplayName(name);
    if (userAuth.user != null) {
      return AuthUserModel.fromFirebaseAuthUser(userAuth.user!);
    }
    return null;
  }

  @override
  AuthUserModel? get currentUser => _firebaseAuth.currentUser != null
      ? AuthUserModel.fromFirebaseAuthUser(_firebaseAuth.currentUser!)
      : null;

  @override
  Future<void> logout() async => _firebaseAuth.signOut();
}
