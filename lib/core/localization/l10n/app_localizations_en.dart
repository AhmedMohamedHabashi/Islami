// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Islami';

  @override
  String get welcome => 'Illuminate Your Heart with Faith';

  @override
  String get language => 'Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get finish => 'Finish';

  @override
  String get welcomeTitle => 'Welcome to Islami';

  @override
  String get welcomeDescription =>
      'Your companion for the Quran, Azkar, and daily worship.';

  @override
  String get readingTitle => 'Reading the Quran';

  @override
  String get readingDescription => 'Read, and your Lord is the Most Generous.';

  @override
  String get azkarTitle => 'Azkar';

  @override
  String get azkarDescription =>
      'Glorify the Name of your Lord, the Most High.';

  @override
  String get radioTitle => 'Holy Quran Radio';

  @override
  String get radioDescription =>
      'Listen to the Holy Quran Radio anytime with ease.';

  @override
  String get ayahRangeTitle => 'Select Memorization Range (Optional)';

  @override
  String get fromAyah => 'From Ayah';

  @override
  String get toAyah => 'To Ayah';

  @override
  String get recitationModeTitle => 'Preferred Recitation Mode';

  @override
  String get repetitionMode => 'Reading and Repetition';

  @override
  String get errorMode => 'Recitation with Simulated Errors';

  @override
  String selectedSurah(String surahName) {
    return 'You selected $surahName';
  }

  @override
  String ayahCount(String count) {
    return '$count Ayahs';
  }

  @override
  String get notStartedYet => 'Not started yet';

  @override
  String get meccan => 'Meccan';

  @override
  String get medinan => 'Medinan';

  @override
  String get dailyWirdRecitation => 'Daily Recitation';

  @override
  String consecutiveDays(String count) {
    return '$count consecutive days';
  }

  @override
  String surahAlKahfVerses(String start, String end) {
    return 'Surah Al-Kahf • Verses $start - $end';
  }

  @override
  String get currentProgress => 'Current Progress';

  @override
  String get continueMemorizationNow => 'Continue Memorization Now';

  @override
  String get noMatchingSurahs => 'No matching Surahs found';

  @override
  String get quranSurahsTitle => 'Quran Surahs';

  @override
  String surahCount(int count) {
    return '$count Surahs';
  }

  @override
  String get radio => 'Radio';

  @override
  String get reciters => 'Reciters';

  @override
  String get time => 'Prayer Times';

  @override
  String get tasbih => 'Tasbih';

  @override
  String get hadith => 'Hadith';

  @override
  String get quran => 'Quran';
}
