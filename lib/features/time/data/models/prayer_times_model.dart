import 'package:islami/core/utils/functions/PrayerTimeFunction.dart';
import 'package:islami/features/time/domain/entities/PrayerTimingHeaderEntity.dart';
import '../../domain/entities/prayer_time_entity.dart';

class PrayerTimesModel {
  final Map<String, String> timings;
  final int gregorianDay;
  final int gregorianMonth;
  final int gregorianYear;
  final int hijriDay;
  final int hijriMonth;
  final int hijriYear;
  final DateTime gregorianDate;

  PrayerTimesModel({
    required this.timings,
    required this.gregorianDay,
    required this.gregorianMonth,
    required this.gregorianYear,
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriYear,
    required this.gregorianDate,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final timingsJson = data['timings'] ?? {};

    Map<String, String> parsedTimings = {};
    timingsJson.forEach((key, value) {
      parsedTimings[key] = value.toString();
    });

    final date = data['date'] ?? {};

    final gregorian = date['gregorian'] ?? {};
    final gDay = int.tryParse(gregorian['day']?.toString() ?? '1') ?? 1;
    final gMonth =
        int.tryParse(gregorian['month']?['number']?.toString() ?? '1') ?? 1;
    final gYear = int.tryParse(gregorian['year']?.toString() ?? '2024') ?? 2024;

    final gDate = DateTime(gYear, gMonth, gDay);

    final hijri = date['hijri'] ?? {};
    final hDay = int.tryParse(hijri['day']?.toString() ?? '1') ?? 1;
    final hMonth =
        int.tryParse(hijri['month']?['number']?.toString() ?? '1') ?? 1;
    final hYear = int.tryParse(hijri['year']?.toString() ?? '1446') ?? 1446;

    return PrayerTimesModel(
      timings: parsedTimings,
      gregorianDay: gDay,
      gregorianMonth: gMonth,
      gregorianYear: gYear,
      hijriDay: hDay,
      hijriMonth: hMonth,
      hijriYear: hYear,
      gregorianDate: gDate,
    );
  }

  PrayerTimingHeaderEntity toHeaderEntity({
    String? nextPrayTime,
    bool isMuted = false,
  }) {
    final nextPrayerKey = PrayerTimeFunction.calculateNextPrayerKey(timings);
    final rawTime = timings[nextPrayerKey] ?? '05:00';
    final formattedTime = PrayerTimeFunction.convertTo12HourFormat(rawTime);

    return PrayerTimingHeaderEntity(
      gregorianDate: gregorianDate,
      hijriDay: hijriDay,
      hijriMonth: hijriMonth,
      hijriYear: hijriYear,
      nextPrayTime: nextPrayTime ?? formattedTime,
      isMuted: isMuted,
    );
  }

  List<PrayerTimeEntity> toPrayerTimesList() {
    final List<String> prayerNames = [
      'Fajr',
      'Dhuhr',
      'Asr',
      'Maghrib',
      'Isha',
    ];
    final nextPrayerKey = PrayerTimeFunction.calculateNextPrayerKey(timings);

    return prayerNames.map((name) {
      String rawTime24 = timings[name] ?? '00:00';
      String formattedTime12 = PrayerTimeFunction.convertTo12HourFormat(
        rawTime24,
      );
      bool isThisNext = (name.toLowerCase() == nextPrayerKey.toLowerCase());

      return PrayerTimeEntity(
        name: name,
        time: formattedTime12,
        isNext: isThisNext,
      );
    }).toList();
  }
}
