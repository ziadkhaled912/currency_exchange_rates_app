import 'package:currency_exchange/core/helpers/nullable.dart';
import 'package:currency_exchange/features/auth/core/data/models/response/auth_user_model.dart';
import 'package:currency_exchange/features/auth/core/data/repository/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';

part 'auth_state.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(const AuthState());

  void getCurrentUser() {
    final user = _authRepository.currentUser;
    emit(state.copyWith(currentUser: Nullable(user)));
  }

  void logout() {
    _authRepository.logout();
    emit(const AuthState());
  }
}
