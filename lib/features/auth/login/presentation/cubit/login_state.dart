part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.isLoading = false,
    this.isObscure = true,
    this.failure,
    this.user,
    this.email,
    this.password,
  });

  final bool isLoading;
  final Failure? failure;
  final AuthUserModel? user;
  final String? email;
  final String? password;
  final bool isObscure;

  bool get isFormValid {
    return (email != null && email!.isValidEmail()) && password != null;
  }

  LoginState loading() {
    return copyWith(
      isLoading: true,
      failure: Nullable(null),
      user: Nullable(null),
    );
  }

  LoginState error(Failure message) {
    return copyWith(
      isLoading: false,
      failure: Nullable(message),
      user: Nullable(null),
    );
  }

  LoginState userLoggedIn(AuthUserModel? user) {
    return copyWith(
      isLoading: false,
      user: Nullable(user),
      failure: Nullable(null),
    );
  }

  LoginState copyWith({
    bool? isLoading,
    Nullable<Failure?>? failure,
    Nullable<AuthUserModel?>? user,
    String? email,
    String? password,
    bool? isObscure,
  }) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure == null ? this.failure : failure.value,
      user: user == null ? this.user : user.value,
      email: email ?? this.email,
      password: password ?? this.password,
      isObscure: isObscure ?? this.isObscure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        failure,
        user,
        email,
        password,
        isObscure,
      ];
}
