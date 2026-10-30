import '../entities/prayer_time_entity.dart';
import '../entities/PrayerTimingHeaderEntity.dart';

abstract class PrayerTimesRepository {
  Future<PrayerTimingHeaderEntity> getPrayerHeaderInfo({
    required double latitude,
    required double longitude,
    required String date,
  });

  Future<List<PrayerTimeEntity>> getPrayerTimesList({
    required double latitude,
    required double longitude,
    required String date,
  });
}
