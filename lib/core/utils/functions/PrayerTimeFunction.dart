class PrayerTimeFunction {
  // دالة تحويل الـ 24 لـ 12 ساعة
  static String convertTo12HourFormat(String time24) {
    try {
      final cleanTime = time24.split(' ').first;
      final parts = cleanTime.split(':');
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

  // دالة معرفة اسم الصلاة القادمة
  static String calculateNextPrayerKey(Map<String, String> timings) {
    try {
      final now = DateTime.now();
      final prayerKeys = ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

      for (var key in prayerKeys) {
        final time24 = timings[key];
        if (time24 == null) continue;

        final cleanTime = time24.split(' ').first;
        final parts = cleanTime.split(':');
        int hour = int.parse(parts[0]);
        int minute = int.parse(parts[1]);

        final prayerTime = DateTime(now.year, now.month, now.day, hour, minute);

        if (prayerTime.isAfter(now)) {
          return key;
        }
      }
      return 'Fajr';
    } catch (e) {
      return 'Fajr';
    }
  }
}
