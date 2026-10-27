import 'package:dio/dio.dart';
import 'package:islami/core/network/api_constants.dart';
import 'package:islami/core/network/interceptors.dart';

class DioFactory {
  static Dio createDio(String baseUrl) {
    return Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: ApiConstants.connectTimeout,
        receiveTimeout: ApiConstants.receiveTimeout,
      ),
    )..interceptors.add(AppInterceptor());
  }
}
