import 'package:islami/features/time/domain/entities/PrayerTimingHeaderEntity.dart';
import 'package:islami/features/time/domain/entities/prayer_time_entity.dart';

abstract class PrayerTimesState {}

class PrayerTimesInitial extends PrayerTimesState {}

class PrayerTimesLoading extends PrayerTimesState {}

class PrayerTimesLoaded extends PrayerTimesState {
  final PrayerTimingHeaderEntity headerData;
  final List<PrayerTimeEntity> prayersList;

  PrayerTimesLoaded({required this.headerData, required this.prayersList});
}

class PrayerTimesError extends PrayerTimesState {
  final String message;

  PrayerTimesError({required this.message});
}
