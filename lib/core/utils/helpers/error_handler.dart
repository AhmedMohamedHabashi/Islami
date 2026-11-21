import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/dio_exception_handler.dart';
import 'package:islami/core/errors/exceptions.dart';
import 'package:islami/core/errors/failures.dart';

class ErrorHandler {
  ErrorHandler._();

  static Future<T> handleErrors<T>(Future<T> Function() request) async {
    try {
      return await request();
    } on ServerException catch (exception) {
      throw ServerFailure(
        DioExceptionHandler.getErrorMessage(exception.statusCode),
      );
    } on NetworkException {
      throw const NetworkFailure();
    } on AppTimeoutException {
      throw const TimeoutFailure();
    } on CacheException {
      throw const CacheFailure();
    } on RequestCancelledException {
      throw const RequestCancelledFailure();
    } catch (_) {
      throw const ServerFailure(AppErrors.unexpectedError);
    }
  }
}
