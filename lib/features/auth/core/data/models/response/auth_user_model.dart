import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthUserModel extends Equatable {
  const AuthUserModel({
    required this.id,
    required this.email,
    this.name,
    this.photoURL,
  });

  final String id;
  final String email;
  final String? name;
  final String? photoURL;

  factory AuthUserModel.fromFirebaseAuthUser(User firebaseUser) {
    return AuthUserModel(
      id: firebaseUser.uid,
      email: firebaseUser.email ?? '',
      name: firebaseUser.displayName,
      photoURL: firebaseUser.photoURL,
    );
  }

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        photoURL,
      ];
}
