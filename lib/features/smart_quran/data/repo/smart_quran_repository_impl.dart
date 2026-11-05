import '../../domain/entities/surah.dart';
import '../../domain/repo/smart_quran_repository.dart';
import '../datasources/surah_remote_data_source.dart';

class SmartQuranRepositoryImpl implements SmartQuranRepository {
  final SurahRemoteDataSource remoteDataSource;

  SmartQuranRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Surah>> getSurahs() async {
    final surahs = await remoteDataSource.getSurahs();

    return surahs;
  }
}
