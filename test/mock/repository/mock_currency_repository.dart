import 'package:currency_exchange/features/home/data/repository/currency_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

@Environment('test')
@Scope('test')
@LazySingleton(as: CurrencyRepository)
class MockCurrencyRepository extends Mock implements CurrencyRepository {}
