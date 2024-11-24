import 'package:currency_exchange/core/data/api_manager/models/response_model.dart';
import 'package:equatable/equatable.dart';

class MessageResponseModel extends ResponseModel {
  MessageResponseModel({required this.success, required this.errorModel});

  factory MessageResponseModel.fromMap(Map<String, dynamic> map) {
    return MessageResponseModel(
      success: (map['success'] as bool?) ?? false,
      errorModel: map['errorModel'] as ErrorModel?,
    );
  }
  final bool? success;
  final ErrorModel? errorModel;

  @override
  List<Object?> get props => [
        success,
        errorModel,
      ];

  Map<String, dynamic> toMap() {
    return {
      'success': success,
      'errorModel': errorModel?.toMap(),
    };
  }
}

class ErrorModel extends Equatable {
  const ErrorModel({
    required this.code,
    required this.info,
  });

  factory ErrorModel.fromMap(Map<String, dynamic> map) {
    return ErrorModel(
      code: (map['code'] as int?) ?? 0,
      info: (map['info'] as String?) ?? '',
    );
  }
  final int code;
  final String info;

  @override
  List<Object> get props => [code, info];

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'info': info,
    };
  }
}
