import 'package:injectable/injectable.dart';

import '../entities/PrayerTimingHeaderEntity.dart';
import '../repositories/prayer_times_repository.dart';

@LazySingleton()
class GetPrayerHeaderUseCase {
  final PrayerTimesRepository repository;

  GetPrayerHeaderUseCase(this.repository);

  Future<PrayerTimingHeaderEntity> call({
    required String city,
    required String country,
    required String date,
  }) async {
    return await repository.getPrayerHeaderInfo(
      city: city,
      country: country,
      date: date,
    );
  }
}
