import 'package:currency_exchange/features/auth/core/data/services/auth_services.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

@Environment('test')
@Scope('test')
@LazySingleton(as: AuthServices)
class MockAuthServices extends Mock implements AuthServices {}
