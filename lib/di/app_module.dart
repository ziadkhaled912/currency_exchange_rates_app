import 'package:currency_exchange/core/data/api_manager/api_constants.dart';
import 'package:currency_exchange/core/helpers/app_logger.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@module
abstract class AppModule {
  @lazySingleton
  Dio get dio {
    final aDio = Dio(
      BaseOptions(
          connectTimeout: const Duration(seconds: 30),
          receiveTimeout: const Duration(seconds: 30),
          sendTimeout: const Duration(seconds: 30),
          followRedirects: true,
          headers: {
            'Accept' : 'application/json',
            'apikey' : ApiConstants.apiKey,
            'x-access-token' : ApiConstants.goldApiKey,
          }
      ),
    );

    if (shouldLog) {
      aDio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }

    return aDio;

  }
}
