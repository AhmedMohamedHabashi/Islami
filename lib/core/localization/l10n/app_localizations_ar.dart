// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'إسلامي';

  @override
  String get welcome => 'أَنِرْ قَلْبَكَ بِالإِيمَانِ';

  @override
  String get language => 'اللغة';

  @override
  String get arabic => 'العربية';

  @override
  String get english => 'الإنجليزية';

  @override
  String get back => 'السابق';

  @override
  String get next => 'التالي';

  @override
  String get finish => 'إنهاء';

  @override
  String get welcomeTitle => 'مرحبًا بك في تطبيق إسلامي';

  @override
  String get welcomeDescription => 'رفيقك في تلاوة القرآن والأذكار والعبادات.';

  @override
  String get readingTitle => 'قراءة القرآن الكريم';

  @override
  String get readingDescription => '﴿اقْرَأْ وَرَبُّكَ الْأَكْرَمُ﴾';

  @override
  String get azkarTitle => 'الأذكار';

  @override
  String get azkarDescription => '﴿سَبِّحِ اسْمَ رَبِّكَ الْأَعْلَى﴾';

  @override
  String get radioTitle => 'إذاعة القرآن الكريم';

  @override
  String get radioDescription =>
      'استمع إلى إذاعة القرآن الكريم مباشرةً عبر التطبيق';

  @override
  String get ayahRangeTitle => 'تحديد نطاق الحفظ (اختياري)';

  @override
  String get fromAyah => 'من الآية';

  @override
  String get toAyah => 'إلى الآية';

  @override
  String get recitationModeTitle => 'نمط التسميع المفضل';

  @override
  String get repetitionMode => 'القراءة والترديد';

  @override
  String get errorMode => 'التسميع بالأخطاء الاصطناعية';

  @override
  String selectedSurah(String surahName) {
    return 'اخترت $surahName';
  }

  @override
  String ayahCount(String count) {
    return '$count آية';
  }

  @override
  String get notStartedYet => 'لم تبدأ بعد';

  @override
  String get meccan => 'مكية';

  @override
  String get medinan => 'مدنية';

  @override
  String get dailyWirdRecitation => 'الورد اليومي - التسميع';

  @override
  String consecutiveDays(String count) {
    return '$count أيام متتالية';
  }

  @override
  String surahAlKahfVerses(String start, String end) {
    return 'سورة الكهف • الآيات $start - $end';
  }

  @override
  String get currentProgress => 'نسبة الإنجاز الحالية';

  @override
  String get continueMemorizationNow => 'متابعة الحفظ الآن';

  @override
  String get noMatchingSurahs => 'لا توجد سور مطابقة';

  @override
  String get quranSurahsTitle => 'سور القرآن الكريم';

  @override
  String surahCount(int count) {
    return '$count سور';
  }

  @override
  String get radio => 'الإذاعة';

  @override
  String get reciters => 'القراء';

  @override
  String get time => 'مواقيت الصلاة';

  @override
  String get tasbih => 'التسبيح';

  @override
  String get hadith => 'الحديث';

  @override
  String get quran => 'القرآن';
}
