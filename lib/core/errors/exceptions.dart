class ServerException implements Exception {
  final int? statusCode;

  const ServerException({this.statusCode});
}

class NetworkException implements Exception {}

class CacheException implements Exception {}

class AppTimeoutException implements Exception {}

class RequestCancelledException implements Exception {}

class MicrophonePermissionException implements Exception {}

class AudioRecordingException implements Exception {}
