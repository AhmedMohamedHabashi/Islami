import 'package:islami/core/utils/functions/PrayerTimeFunction.dart';
import 'package:islami/features/time/domain/entities/PrayerTimingHeaderEntity.dart';
import '../../domain/entities/prayer_time_entity.dart';

class PrayerTimesModel {
  final Map<String, String> timings;
  final String gregorianDate;
  final String hijriDate;
  final String dayName;

  PrayerTimesModel({
    required this.timings,
    required this.gregorianDate,
    required this.hijriDate,
    required this.dayName,
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
    final gDay = gregorian['day'] ?? '';

    final monthData = gregorian['month'] ?? {};
    final gMonth = (monthData['abbrev'] ?? monthData['en'] ?? '').toString();
    final formattedGMonth = gMonth.length >= 3
        ? gMonth.substring(0, 3)
        : gMonth;
    final gYear = gregorian['year'] ?? '';
    final formattedGregorian = '$gDay $formattedGMonth,\n$gYear';

    final hijri = date['hijri'] ?? {};
    final hDay = hijri['day'] ?? '';
    final hMonthEn = hijri['month'] != null
        ? (hijri['month']['en'] ?? '').toString()
        : '';
    final hMonth = hMonthEn.length >= 3 ? hMonthEn.substring(0, 3) : hMonthEn;
    final hYear = hijri['year'] ?? '';
    final formattedHijri = '$hDay $hMonth,\n$hYear';

    final weekday = gregorian['weekday'] != null
        ? gregorian['weekday']['en'] ?? ''
        : '';

    return PrayerTimesModel(
      timings: parsedTimings,
      gregorianDate: formattedGregorian,
      hijriDate: formattedHijri,
      dayName: weekday,
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
      hijriDate: hijriDate,
      dayName: dayName,
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
