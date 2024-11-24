part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.currentUser,
    this.uid,
  });

  final AuthUserModel? currentUser;
  final String? uid;

  bool get isAuthenticated => currentUser != null;

  AuthState copyWith({
    Nullable<AuthUserModel?>? currentUser,
    Nullable<String?>? uid,
  }) {
    return AuthState(
      currentUser: currentUser == null ? this.currentUser : currentUser.value,
      uid: uid == null ? this.uid : uid.value,
    );
  }

  @override
  List<Object?> get props => [currentUser, uid, isAuthenticated];
}
