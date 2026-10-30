import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/network/endpoints.dart';
import '../models/prayer_times_model.dart';

@LazySingleton()
class PrayerRemoteDataSource {
  final Dio dio;

  PrayerRemoteDataSource(@Named('prayerDio') this.dio);

  Future<PrayerTimesModel> getPrayerTimes({
    required double latitude,
    required double longitude,
    required String date,
  }) async {
    final response = await dio.get(
      '/${Endpoints.prayerTimings}/$date',
      queryParameters: {'latitude': latitude, 'longitude': longitude},
    );

    if (response.statusCode == 200) {
      return PrayerTimesModel.fromJson(response.data);
    } else {
      throw Exception('Failed to load prayer times from server');
    }
  }
}
