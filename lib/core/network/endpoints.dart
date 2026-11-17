class Endpoints {
  static const String prayerTimings = 'timings';
  static const String azkarItems = 'azkar/items';

  // Smart Quran
  static const String quranSurahs = 'surah';

  static String quranSurahDetails(int surahNumber) {
    return 'surah/$surahNumber';
  }
}
