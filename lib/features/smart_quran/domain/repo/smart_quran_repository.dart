import '../entities/ayah.dart';
import '../entities/surah.dart';

abstract class SmartQuranRepository {
  Future<List<Surah>> getSurahs();

  Future<List<Ayah>> getAyahs({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  });
}
