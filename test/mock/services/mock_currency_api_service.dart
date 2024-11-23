import 'package:currency_exchange/features/home/data/services/currency_api_service.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

@Environment('test')
@Scope('test')
@LazySingleton(as: CurrencyApiServices)
class MockCurrencyApiServices extends Mock implements CurrencyApiServices {}
