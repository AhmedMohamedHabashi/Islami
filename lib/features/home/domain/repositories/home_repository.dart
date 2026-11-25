import 'package:islami/features/home/domain/entities/surah_entity.dart';

abstract class HomeRepository {
  Future<List<SurahEntity>> getSurahs();

  Future<List<SurahEntity>> getRecentSurahs();
}
