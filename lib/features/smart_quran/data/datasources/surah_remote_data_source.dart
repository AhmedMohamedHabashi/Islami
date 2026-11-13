import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../models/ayah_model.dart';
import '../models/surah_model.dart';

@lazySingleton
class SurahRemoteDataSource {
  final Dio dio;

  SurahRemoteDataSource({@Named('smartQuranDio') required this.dio});

  // Get all Quran surahs.
  Future<List<SurahModel>> getSurahs() async {
    final response = await dio.get('surah');

    final responseData = Map<String, dynamic>.from(response.data as Map);

    if (responseData['code'] != 200) {
      throw Exception('Failed to load Quran surahs');
    }

    final List<dynamic> surahsJson = responseData['data'] as List<dynamic>;

    return surahsJson.map((surah) {
      return SurahModel.fromJson(Map<String, dynamic>.from(surah as Map));
    }).toList();
  }

  // Get ayahs of a specific surah and range.
  Future<List<AyahModel>> getAyahs({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) async {
    final response = await dio.get('surah/$surahNumber');

    final responseData = Map<String, dynamic>.from(response.data as Map);

    if (responseData['code'] != 200) {
      throw Exception('Failed to load Quran ayahs');
    }

    final surahData = Map<String, dynamic>.from(responseData['data'] as Map);

    final List<dynamic> ayahsJson = surahData['ayahs'] as List<dynamic>;

    return ayahsJson
        .map(
          (ayah) => AyahModel.fromJson(Map<String, dynamic>.from(ayah as Map)),
        )
        .where(
          (ayah) =>
              ayah.numberInSurah >= startAyah && ayah.numberInSurah <= endAyah,
        )
        .toList();
  }
}
