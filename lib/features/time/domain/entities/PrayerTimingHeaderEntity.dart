class PrayerTimingHeaderEntity {
  final String gregorianDate;
  final String hijriDate;
  final String dayName;
  final String nextPrayTime;
  final bool isMuted;

  const PrayerTimingHeaderEntity({
    required this.gregorianDate,
    required this.hijriDate,
    required this.dayName,
    required this.nextPrayTime,
    this.isMuted = false,
  });
}
