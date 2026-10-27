import '../entities/prayer_time_entity.dart';
import '../entities/PrayerTimingHeaderEntity.dart';

abstract class PrayerTimesRepository {
  Future<PrayerTimingHeaderEntity> getPrayerHeaderInfo({
    required String city,
    required String country,
    required String date,
  });

  Future<List<PrayerTimeEntity>> getPrayerTimesList({
    required String city,
    required String country,
    required String date,
  });
}
