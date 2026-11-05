import 'package:injectable/injectable.dart';
import '../entities/PrayerTimingHeaderEntity.dart';
import '../repositories/prayer_times_repository.dart';

@LazySingleton()
class GetPrayerHeaderUseCase {
  final PrayerTimesRepository repository;

  GetPrayerHeaderUseCase(this.repository);

  Future<PrayerTimingHeaderEntity> call({
    required double latitude,
    required double longitude,
    required String date,
  }) async {
    return await repository.getPrayerHeaderInfo(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );
  }
}
