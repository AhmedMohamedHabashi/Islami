class PrayerTimingHeaderEntity {
  final DateTime gregorianDate;
  final int hijriDay;
  final int hijriMonth;
  final int hijriYear;
  final String nextPrayTime;
  final bool isMuted;

  PrayerTimingHeaderEntity({
    required this.gregorianDate,
    required this.hijriDay,
    required this.hijriMonth,
    required this.hijriYear,
    required this.nextPrayTime,
    required this.isMuted,
  });
}
