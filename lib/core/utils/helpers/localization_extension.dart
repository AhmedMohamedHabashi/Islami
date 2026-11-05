import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';

extension LocalizationExtension on BuildContext {
  String translateAzkarTitle(String apiTitle) {
    final l10n = AppLocalizations.of(this)!;

    switch (apiTitle.trim()) {
      case 'أذكار الصباح':
      case 'Morning Azkar':
        return l10n.morningAzkar;
      case 'أذكار المساء':
      case 'Evening Azkar':
        return l10n.eveningAzkar;
      case 'أذكار الاستيقاظ من النوم':
      case 'Waking Up Azkar':
        return l10n.wakingUpAzkar;
      case 'أذكار الآذان':
      case 'Adhan Azkar':
        return l10n.adhanAzkar;
      case 'الأذكار بعد السلام من الصلاة':
      case 'After Prayer Azkar':
        return l10n.afterPrayerAzkar;
      case 'أذكار النوم':
      case 'Sleeping Azkar':
        return l10n.sleepingAzkar;
      default:
        return apiTitle;
    }
  }

  String formatTime(DateTime time) {
    final locale = AppLocalizations.of(this)!.localeName;
    return DateFormat('hh:mm a', locale).format(time);
  }

  String formatDayName(DateTime date) {
    final locale = AppLocalizations.of(this)!.localeName;
    return DateFormat('EEEE', locale).format(date);
  }

  String formatGregorianDate(DateTime date) {
    final locale = AppLocalizations.of(this)!.localeName;
    final day = DateFormat('dd', locale).format(date);
    final month = DateFormat('MMM', locale).format(date);
    final year = DateFormat('yyyy', locale).format(date);
    return '$day $month,\n$year';
  }

  String translatePrayerName(String apiName) {
    final l10n = AppLocalizations.of(this)!;
    switch (apiName.trim()) {
      case 'Fajr':
      case 'الفجر':
        return l10n.fajr;
      case 'Dhuhr':
      case 'الظهر':
        return l10n.dhuhr;
      case 'Asr':
      case 'العصر':
        return l10n.asr;
      case 'Maghrib':
      case 'المغرب':
        return l10n.maghrib;
      case 'Isha':
      case 'العشاء':
        return l10n.isha;
      default:
        return apiName;
    }
  }

  String formatHijriDate(int day, int month, int year) {
    final locale = AppLocalizations.of(this)!.localeName;

    final hijriMonthsAr = [
      'محرم',
      'صفر',
      'ربيع ١',
      'ربيع ٢',
      'جمادى ١',
      'جمادى ٢',
      'رجب',
      'شعبان',
      'رمضان',
      'شوال',
      'ذو القعدة',
      'ذو الحجة',
    ];

    final hijriMonthsEn = [
      'Muh',
      'Saf',
      'Rab I',
      'Rab II',
      'Jum I',
      'Jum II',
      'Raj',
      'Sha',
      'Ram',
      'Shaw',
      'Dhu Q',
      'Dhu H',
    ];

    final monthName = locale == 'ar'
        ? hijriMonthsAr[month - 1]
        : hijriMonthsEn[month - 1];

    return '$day $monthName,\n$year';
  }
}
