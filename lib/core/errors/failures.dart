import 'app_errors.dart';

abstract class Failure {
  final String message;

  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure([super.message = AppErrors.serverError]);
}

class NetworkFailure extends Failure {
  const NetworkFailure([super.message = AppErrors.networkError]);
}

class CacheFailure extends Failure {
  const CacheFailure([super.message = AppErrors.cacheError]);
}

class TimeoutFailure extends Failure {
  const TimeoutFailure([super.message = AppErrors.timeoutError]);
}

class RequestCancelledFailure extends Failure {
  const RequestCancelledFailure([super.message = AppErrors.requestCancelled]);
}
