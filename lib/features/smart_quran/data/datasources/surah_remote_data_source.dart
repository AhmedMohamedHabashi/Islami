import 'package:dio/dio.dart';
import '../models/surah_model.dart';

class SurahRemoteDataSource {
  final Dio dio;

  SurahRemoteDataSource({required this.dio});

  Future<List<SurahModel>> getSurahs() async {
    final response = await dio.get('/surah');

    final responseData = Map<String, dynamic>.from(response.data as Map);

    if (responseData['code'] != 200) {
      throw Exception('Failed to load Quran surahs');
    }

    final List<dynamic> surahsJson = responseData['data'] as List<dynamic>;

    return surahsJson.map((surah) {
      return SurahModel.fromJson(Map<String, dynamic>.from(surah as Map));
    }).toList();
  }
}
