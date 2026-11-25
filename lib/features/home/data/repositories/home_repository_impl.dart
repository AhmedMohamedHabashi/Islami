import 'package:dio/dio.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/failures.dart';
import 'package:islami/features/home/data/datasources/home_local_data_source.dart';
import 'package:islami/features/home/data/datasources/home_remote_data_source.dart';
import 'package:islami/features/home/domain/entities/surah_entity.dart';
import 'package:islami/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final HomeLocalDataSource localDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  List<SurahEntity>? _cache;

  @override
  Future<List<SurahEntity>> getSurahs() async {
    return _cache ??= await _fetchSurahs();
  }

  @override
  Future<List<SurahEntity>> getRecentSurahs() async {
    final surahs = await getSurahs();
    final numbers = await localDataSource.getRecentSurahNumbers();

    return numbers
        .map((number) => surahs.firstWhere((s) => s.number == number))
        .toList();
  }

  Future<List<SurahEntity>> _fetchSurahs() async {
    try {
      final models = await remoteDataSource.getSurahs();
      return List<SurahEntity>.of(models)
        ..sort((a, b) => a.number.compareTo(b.number));
    } on DioException catch (e) {
      switch (e.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          throw const TimeoutFailure();
        case DioExceptionType.connectionError:
          throw const NetworkFailure();
        default:
          throw const ServerFailure();
      }
    } catch (_) {
      throw const ServerFailure(AppErrors.unexpectedError);
    }
  }
}
