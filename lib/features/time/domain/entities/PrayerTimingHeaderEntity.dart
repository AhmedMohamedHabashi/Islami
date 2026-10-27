class PrayerTimingHeaderEntity {
  final String gregorianDate; // 16 Jul, 2024
  final String hijriDate; // 09 Muh, 1446
  final String dayName; // Tuesday
  final String nextPrayTime; // 02:32
  final bool isMuted; // حالة زرار الصوت

  const PrayerTimingHeaderEntity({
    required this.gregorianDate,
    required this.hijriDate,
    required this.dayName,
    required this.nextPrayTime,
    this.isMuted = false,
  });
}
