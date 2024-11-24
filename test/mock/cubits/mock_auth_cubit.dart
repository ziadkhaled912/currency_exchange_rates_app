import 'package:bloc_test/bloc_test.dart';
import 'package:currency_exchange/features/auth/core/presentation/auth_cubit/auth_cubit.dart';
import 'package:injectable/injectable.dart';

import '../../../lib/features/auth/core/data/models/response/auth_user_model_mock.dart';

@Environment(Environment.test)
@Scope(Environment.test)
@Injectable(as: AuthCubit)
class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}
