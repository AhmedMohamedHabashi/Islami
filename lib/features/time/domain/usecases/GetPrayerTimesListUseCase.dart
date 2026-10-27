import 'package:injectable/injectable.dart';

import '../entities/prayer_time_entity.dart';
import '../repositories/prayer_times_repository.dart';

@LazySingleton()
class GetPrayerTimesListUseCase {
  final PrayerTimesRepository repository;

  GetPrayerTimesListUseCase(this.repository);

  Future<List<PrayerTimeEntity>> call({
    required String city,
    required String country,
    required String date,
  }) async {
    return await repository.getPrayerTimesList(
      city: city,
      country: country,
      date: date,
    );
  }
}
