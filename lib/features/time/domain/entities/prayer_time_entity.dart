class PrayerTimeEntity {
  final String name;
  final String time;
  final bool isNext;

  const PrayerTimeEntity({
    required this.name,
    required this.time,
    this.isNext = false,
  });
}
