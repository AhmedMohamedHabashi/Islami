import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/network/api_constants.dart';
import 'package:islami/core/network/dio_factory.dart';

@module
abstract class RegisterModule {
  @lazySingleton
  Connectivity get connectivity => Connectivity();

  @lazySingleton
  @Named('prayerDio')
  Dio get dio => DioFactory.createDio(ApiConstants.prayerTimesBaseUrl);
}
