import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:currency_exchange/core/extensions/validators.dart';
import 'package:currency_exchange/core/helpers/nullable.dart';
import 'package:currency_exchange/features/auth/core/data/models/request/login_in_request_model.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/core/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'login_state.dart';

@injectable
class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authRepository) : super(const LoginState());

  final AuthRepository _authRepository;

  Future<void> loginWithEmailAndPassword() async {
    if (!state.isFormValid) return;
    emit(state.loading());
    final request = LoginRequestModel(
      email: state.email!,
      password: state.password!,
    );
    final user = await _authRepository.loginWithEmailAndPassword(request);
    user.fold(
      (failure) => emit(state.error(failure)),
      (user) => emit(state.userLoggedIn(user)),
    );
  }

  void onEmailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void onPasswordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void toggleObscure() {
    emit(state.copyWith(isObscure: !state.isObscure));
  }
}
