import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class FailureInfo extends Equatable {
  const FailureInfo({
    this.response,
    this.exception,
  });
  final Response<dynamic>? response;
  final dynamic exception;

  @override 
  List<Object?> get props => [response, exception];
}
