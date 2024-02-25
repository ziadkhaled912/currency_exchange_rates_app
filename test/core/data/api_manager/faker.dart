import 'package:currency_exchange/core/data/api_manager/api_manager.dart';
import 'package:mocktail/mocktail.dart';

class MockAPIsManager extends Mock implements APIsManager {}

class RequestFake extends Fake implements Request {}

class EmptyRequestModelFake extends Fake implements EmptyRequestModel {}

