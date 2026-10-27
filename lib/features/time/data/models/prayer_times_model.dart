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
    final gMonth = gregorian['month'] != null
        ? gregorian['month']['abbrev'] ?? ''
        : '';
    final gYear = gregorian['year'] ?? '';
    final formattedGregorian = '$gDay $gMonth, $gYear';

    final hijri = date['hijri'] ?? {};
    final hDay = hijri['day'] ?? '';
    final hMonthEn = hijri['month'] != null
        ? (hijri['month']['en'] ?? '').toString()
        : '';
    final hMonth = hMonthEn.length >= 3 ? hMonthEn.substring(0, 3) : hMonthEn;
    final hYear = hijri['year'] ?? '';
    final formattedHijri = '$hDay $hMonth, $hYear';

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
    String nextPrayTime = '00:32',
    bool isMuted = false,
  }) {
    return PrayerTimingHeaderEntity(
      gregorianDate: gregorianDate,
      hijriDate: hijriDate,
      dayName: dayName,
      nextPrayTime: nextPrayTime,
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

    return prayerNames.map((name) {
      String rawTime24 = timings[name] ?? '00:00';
      String formattedTime12 = _convertTo12HourFormat(rawTime24);

      return PrayerTimeEntity(name: name, time: formattedTime12, isNext: false);
    }).toList();
  }

  String _convertTo12HourFormat(String time24) {
    try {
      final parts = time24.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      String period = hour >= 12 ? 'PM' : 'AM';

      if (hour == 0) {
        hour = 12;
      } else if (hour > 12) {
        hour -= 12;
      }

      String formattedMinute = minute.toString().padLeft(2, '0');
      return '${hour.toString().padLeft(2, '0')}:$formattedMinute $period';
    } catch (e) {
      return time24;
    }
  }
}
