import 'package:dio/dio.dart';
import 'package:islami/features/home/data/models/home_surah_model.dart';

class HomeRemoteDataSource {
  static const String _surahsPath = 'surah';

  final Dio dio;

  HomeRemoteDataSource({required this.dio});

  Future<List<HomeSurahModel>> getSurahs() async {
    final response = await dio.get(_surahsPath);

    final responseData = Map<String, dynamic>.from(response.data as Map);
    final surahsJson = responseData['data'] as List<dynamic>;

    return surahsJson.map((surah) {
      return HomeSurahModel.fromJson(Map<String, dynamic>.from(surah as Map));
    }).toList();
  }
}
