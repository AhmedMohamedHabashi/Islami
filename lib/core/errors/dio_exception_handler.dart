import 'dart:io';
import 'package:dio/dio.dart';
import 'app_errors.dart';
import 'exceptions.dart';

class DioExceptionHandler {
  DioExceptionHandler._();

  static Never handle(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        throw AppTimeoutException();

      case DioExceptionType.connectionError:
        throw NetworkException();

      case DioExceptionType.badResponse:
        throw ServerException(statusCode: exception.response?.statusCode);

      case DioExceptionType.cancel:
        throw RequestCancelledException();

      case DioExceptionType.badCertificate:
        throw ServerException();

      case DioExceptionType.unknown:
        if (exception.error is SocketException) {
          throw NetworkException();
        }

        throw ServerException();
    }
  }

  static String getErrorMessage(int? statusCode) {
    switch (statusCode) {
      case 400:
        return AppErrors.badRequest;

      case 401:
        return AppErrors.unauthorized;

      case 403:
        return AppErrors.forbidden;

      case 404:
        return AppErrors.notFound;

      case 408:
        return AppErrors.timeoutError;

      case 409:
        return AppErrors.conflict;

      case 422:
        return AppErrors.validationError;

      case 429:
        return AppErrors.tooManyRequests;

      case 500:
        return AppErrors.serverError;

      case 502:
      case 503:
        return AppErrors.serviceUnavailable;

      case 504:
        return AppErrors.timeoutError;

      default:
        return AppErrors.unexpectedError;
    }
  }
}
