import 'package:injectable/injectable.dart';
import 'package:islami/features/time/domain/entities/PrayerTimingHeaderEntity.dart';
import '../../domain/entities/prayer_time_entity.dart';
import '../../domain/repositories/prayer_times_repository.dart'; // استيراد العقد من الدومين
import '../datasources/prayer_remote_data_source.dart';

@LazySingleton(as: PrayerTimesRepository)
class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  // 👈 ضفنا الـ implements هنا
  final PrayerRemoteDataSource remoteDataSource;

  PrayerTimesRepositoryImpl({required this.remoteDataSource});

  @override // 👈 يفضل نكتبها للتأكد إن الدوال دي مطابقة للعقد
  Future<PrayerTimingHeaderEntity> getPrayerHeaderInfo({
    required String city,
    required String country,
    required String date,
  }) async {
    final model = await remoteDataSource.getPrayerTimes(
      city: city,
      country: country,
      date: date,
    );

    return model.toHeaderEntity();
  }

  @override // 👈 يفضل نكتبها هنا كمان
  Future<List<PrayerTimeEntity>> getPrayerTimesList({
    required String city,
    required String country,
    required String date,
  }) async {
    final model = await remoteDataSource.getPrayerTimes(
      city: city,
      country: country,
      date: date,
    );

    return model.toPrayerTimesList();
  }
}
