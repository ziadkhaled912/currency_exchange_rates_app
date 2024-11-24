part of 'register_cubit.dart';

class RegisterState extends Equatable {
  const RegisterState({
    this.isLoading = false,
    this.isObscure = true,
    this.isEmailVerified = false,
    this.failure,
    this.user,
    this.name,
    this.email,
    this.password,
  });

  final bool isLoading;
  final bool isObscure;
  final Failure? failure;
  final AuthUserModel? user;
  final String? name;
  final String? email;
  final String? password;
  final bool isEmailVerified;

  bool get isFormValid {
    return (name != null && name!.isNotEmpty) &&
        (email != null && email!.isValidEmail()) &&
        (password != null && password!.length >= 6);
  }

  RegisterState loading() {
    return copyWith(isLoading: true);
  }

  RegisterState error(Failure failure) {
    return copyWith(
      isLoading: false,
      failure: Nullable(failure),
    );
  }

  RegisterState userRegistered(AuthUserModel? user) {
    return copyWith(isLoading: false, user: Nullable(user));
  }

  RegisterState copyWith({
    bool? isLoading,
    bool? isObscure,
    Nullable<Failure?>? failure,
    Nullable<AuthUserModel?>? user,
    String? name,
    String? email,
    String? password,
    bool? isEmailVerified,
  }) {
    return RegisterState(
      isLoading: isLoading ?? this.isLoading,
      isObscure: isObscure ?? this.isObscure,
      failure: failure == null ? this.failure : failure.value,
      user: user == null ? this.user : user.value,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isObscure,
        failure,
        user,
        name,
        email,
        password,
        isEmailVerified,
      ];
}
