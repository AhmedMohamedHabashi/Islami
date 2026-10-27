class PrayerTimeEntity {
  final String name; // اسم الصلاة (مثال: الفجر، الظهر)
  final String time; // وقت الصلاة (مثال: 05:00 AM)
  final bool isNext; // تحديد هل دي الصلاة القادمة عشان الـ UI يبرزها

  const PrayerTimeEntity({
    required this.name,
    required this.time,
    this.isNext = false,
  });
}
