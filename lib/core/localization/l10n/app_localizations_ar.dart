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
}
