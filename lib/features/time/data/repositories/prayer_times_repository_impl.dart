import 'package:injectable/injectable.dart';
import 'package:islami/features/time/domain/entities/PrayerTimingHeaderEntity.dart';
import '../../domain/entities/prayer_time_entity.dart';
import '../../domain/repositories/prayer_times_repository.dart'; // استيراد العقد من الدومين
import '../datasources/prayer_remote_data_source.dart';

@LazySingleton(as: PrayerTimesRepository)
class PrayerTimesRepositoryImpl implements PrayerTimesRepository {
  final PrayerRemoteDataSource remoteDataSource;

  PrayerTimesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<PrayerTimingHeaderEntity> getPrayerHeaderInfo({
    required double latitude,
    required double longitude,
    required String date,
  }) async {
    final model = await remoteDataSource.getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );

    return model.toHeaderEntity();
  }

  @override
  Future<List<PrayerTimeEntity>> getPrayerTimesList({
    required double latitude,
    required double longitude,
    required String date,
  }) async {
    final model = await remoteDataSource.getPrayerTimes(
      latitude: latitude,
      longitude: longitude,
      date: date,
    );

    return model.toPrayerTimesList();
  }
}
