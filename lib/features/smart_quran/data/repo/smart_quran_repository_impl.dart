import 'package:injectable/injectable.dart';
import 'package:islami/core/utils/helpers/error_handler.dart';
import '../../domain/entities/ayah.dart';
import '../../domain/entities/surah.dart';
import '../../domain/repo/smart_quran_repository.dart';
import '../datasources/surah_remote_data_source.dart';

@LazySingleton(as: SmartQuranRepository)
class SmartQuranRepositoryImpl implements SmartQuranRepository {
  final SurahRemoteDataSource remoteDataSource;

  SmartQuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Surah>> getSurahs() {
    return ErrorHandler.handleErrors(() => remoteDataSource.getSurahs());
  }

  @override
  Future<List<Ayah>> getAyahs({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) {
    return ErrorHandler.handleErrors(
      () => remoteDataSource.getAyahs(
        surahNumber: surahNumber,
        startAyah: startAyah,
        endAyah: endAyah,
      ),
    );
  }
}
