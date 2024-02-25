import 'package:currency_exchange/core/data/api_manager/models/message_response_model.dart';
import 'package:currency_exchange/core/helpers/app_faker.dart';

class MessageResponseModelMock {
  static final mock = MessageResponseModel(
    success: false,
    errorModel: ErrorModel(
      code: AppFaker.randomInt(),
      info: AppFaker.sentence,
    ),
  );
}
