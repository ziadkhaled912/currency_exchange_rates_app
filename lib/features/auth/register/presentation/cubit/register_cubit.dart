import 'package:bloc/bloc.dart';
import 'package:currency_exchange/core/data/api_manager/models/failures/failure.dart';
import 'package:currency_exchange/core/extensions/validators.dart';
import 'package:currency_exchange/core/helpers/nullable.dart';
import 'package:currency_exchange/features/auth/core/data/models/request/sign_up_request_model.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/core/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._authRepository) : super(const RegisterState());

  final AuthRepository _authRepository;

  Future<void> registerWithEmailAndPassword() async {
    if (!state.isFormValid) return;
    emit(state.loading());
    final request = SignUpRequestModel(
      email: state.email!,
      password: state.password!,
      name: state.name!,
    );
    final user = await _authRepository.signUpWithEmailAndPassword(request);
    user.fold(
      (failure) => emit(state.error(failure)),
      (user) => emit(state.userRegistered(user)),
    );
  }

  void onNameChanged(String name) {
    emit(state.copyWith(name: name));
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
