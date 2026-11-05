import '../entities/surah.dart';

abstract class SmartQuranRepository {
  Future<List<Surah>> getSurahs();
}
