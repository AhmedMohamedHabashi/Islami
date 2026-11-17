import 'package:injectable/injectable.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/dio_exception_handler.dart';
import 'package:islami/core/errors/exceptions.dart';
import 'package:islami/core/errors/failures.dart';

import '../../domain/entities/ayah.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repo/smart_quran_repository.dart';
import '../datasources/surah_remote_data_source.dart';

@LazySingleton(as: SmartQuranRepository)
class SmartQuranRepositoryImpl implements SmartQuranRepository {
  final SurahRemoteDataSource remoteDataSource;

  SmartQuranRepositoryImpl({required this.remoteDataSource});

  // Handle exceptions and convert them into failures.
  Future<T> _handleErrors<T>(Future<T> Function() request) async {
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

  @override
  Future<List<Surah>> getSurahs() {
    return _handleErrors(() => remoteDataSource.getSurahs());
  }

  @override
  Future<List<Ayah>> getAyahs({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) {
    return _handleErrors(
      () => remoteDataSource.getAyahs(
        surahNumber: surahNumber,
        startAyah: startAyah,
        endAyah: endAyah,
      ),
    );
  }
}
