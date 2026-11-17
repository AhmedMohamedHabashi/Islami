import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Islami'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Illuminate Your Heart with Faith'**
  String get welcome;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @arabic.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get arabic;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @welcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Islami'**
  String get welcomeTitle;

  /// No description provided for @welcomeDescription.
  ///
  /// In en, this message translates to:
  /// **'Your companion for the Quran, Azkar, and daily worship.'**
  String get welcomeDescription;

  /// No description provided for @readingTitle.
  ///
  /// In en, this message translates to:
  /// **'Reading the Quran'**
  String get readingTitle;

  /// No description provided for @readingDescription.
  ///
  /// In en, this message translates to:
  /// **'Read, and your Lord is the Most Generous.'**
  String get readingDescription;

  /// No description provided for @azkarTitle.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkarTitle;

  /// No description provided for @azkarDescription.
  ///
  /// In en, this message translates to:
  /// **'Glorify the Name of your Lord, the Most High.'**
  String get azkarDescription;

  /// No description provided for @radioTitle.
  ///
  /// In en, this message translates to:
  /// **'Holy Quran Radio'**
  String get radioTitle;

  /// No description provided for @radioDescription.
  ///
  /// In en, this message translates to:
  /// **'Listen to the Holy Quran Radio anytime with ease.'**
  String get radioDescription;

  /// No description provided for @ayahRangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Memorization Range (Optional)'**
  String get ayahRangeTitle;

  /// No description provided for @fromAyah.
  ///
  /// In en, this message translates to:
  /// **'From Ayah'**
  String get fromAyah;

  /// No description provided for @toAyah.
  ///
  /// In en, this message translates to:
  /// **'To Ayah'**
  String get toAyah;

  /// No description provided for @recitationModeTitle.
  ///
  /// In en, this message translates to:
  /// **'Preferred Recitation Mode'**
  String get recitationModeTitle;

  /// No description provided for @repetitionMode.
  ///
  /// In en, this message translates to:
  /// **'Read & Repeat'**
  String get repetitionMode;

  /// No description provided for @errorMode.
  ///
  /// In en, this message translates to:
  /// **'Smart Recitation'**
  String get errorMode;

  /// No description provided for @selectedSurah.
  ///
  /// In en, this message translates to:
  /// **'You selected {surahName}'**
  String selectedSurah(String surahName);

  /// No description provided for @ayahCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Ayahs'**
  String ayahCount(String count);

  /// No description provided for @notStartedYet.
  ///
  /// In en, this message translates to:
  /// **'Not started yet'**
  String get notStartedYet;

  /// No description provided for @meccan.
  ///
  /// In en, this message translates to:
  /// **'Meccan'**
  String get meccan;

  /// No description provided for @medinan.
  ///
  /// In en, this message translates to:
  /// **'Medinan'**
  String get medinan;

  /// No description provided for @dailyWirdRecitation.
  ///
  /// In en, this message translates to:
  /// **'Daily Recitation'**
  String get dailyWirdRecitation;

  /// No description provided for @consecutiveDays.
  ///
  /// In en, this message translates to:
  /// **'{count} consecutive days'**
  String consecutiveDays(String count);

  /// No description provided for @surahAlKahfVerses.
  ///
  /// In en, this message translates to:
  /// **'Surah Al-Kahf • Verses {start} - {end}'**
  String surahAlKahfVerses(String start, String end);

  /// No description provided for @currentProgress.
  ///
  /// In en, this message translates to:
  /// **'Current Progress'**
  String get currentProgress;

  /// No description provided for @continueMemorizationNow.
  ///
  /// In en, this message translates to:
  /// **'Continue Memorization Now'**
  String get continueMemorizationNow;

  /// No description provided for @noMatchingSurahs.
  ///
  /// In en, this message translates to:
  /// **'No matching Surahs found'**
  String get noMatchingSurahs;

  /// No description provided for @quranSurahsTitle.
  ///
  /// In en, this message translates to:
  /// **'Quran Surahs'**
  String get quranSurahsTitle;

  /// No description provided for @surahCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Surahs'**
  String surahCount(int count);

  /// No description provided for @radio.
  ///
  /// In en, this message translates to:
  /// **'Radio'**
  String get radio;

  /// No description provided for @reciters.
  ///
  /// In en, this message translates to:
  /// **'Reciters'**
  String get reciters;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get time;

  /// No description provided for @tasbih.
  ///
  /// In en, this message translates to:
  /// **'Tasbih'**
  String get tasbih;

  /// No description provided for @hadith.
  ///
  /// In en, this message translates to:
  /// **'Hadith'**
  String get hadith;

  /// No description provided for @quran.
  ///
  /// In en, this message translates to:
  /// **'Quran'**
  String get quran;

  /// No description provided for @recitationReportHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Guide'**
  String get recitationReportHelpTitle;

  /// No description provided for @recitationReportHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'The report displays your recitation accuracy, correct, incorrect, and missing words, along with an analysis of flagged words and recommendations to help you review your recitation.'**
  String get recitationReportHelpMessage;

  /// No description provided for @recitationReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Recitation Review Report'**
  String get recitationReportTitle;

  /// No description provided for @recitationPronunciationAlert.
  ///
  /// In en, this message translates to:
  /// **'Pronunciation alert for: ({word})'**
  String recitationPronunciationAlert(Object word);

  /// No description provided for @recitationAyahNumber.
  ///
  /// In en, this message translates to:
  /// **'Ayah {number}'**
  String recitationAyahNumber(Object number);

  /// No description provided for @recitationCorrectFace.
  ///
  /// In en, this message translates to:
  /// **'Correct pronunciation ({ruleName})'**
  String recitationCorrectFace(Object ruleName);

  /// No description provided for @recitationRecordedTitle.
  ///
  /// In en, this message translates to:
  /// **'Your recorded recitation'**
  String get recitationRecordedTitle;

  /// No description provided for @recitationGuidanceTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Guidance for Your Next Review'**
  String get recitationGuidanceTitle;

  /// No description provided for @recitationApproveButton.
  ///
  /// In en, this message translates to:
  /// **'Approve Result'**
  String get recitationApproveButton;

  /// No description provided for @recitationRetryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry Recitation'**
  String get recitationRetryButton;

  /// No description provided for @startRecitation.
  ///
  /// In en, this message translates to:
  /// **'Start Recitation'**
  String get startRecitation;

  /// No description provided for @prayTimeHeader.
  ///
  /// In en, this message translates to:
  /// **'Prayer Times'**
  String get prayTimeHeader;

  /// No description provided for @fajr.
  ///
  /// In en, this message translates to:
  /// **'Fajr'**
  String get fajr;

  /// No description provided for @dhuhr.
  ///
  /// In en, this message translates to:
  /// **'Dhuhr'**
  String get dhuhr;

  /// No description provided for @asr.
  ///
  /// In en, this message translates to:
  /// **'Asr'**
  String get asr;

  /// No description provided for @maghrib.
  ///
  /// In en, this message translates to:
  /// **'Maghrib'**
  String get maghrib;

  /// No description provided for @isha.
  ///
  /// In en, this message translates to:
  /// **'Isha'**
  String get isha;

  /// No description provided for @nextPray.
  ///
  /// In en, this message translates to:
  /// **'Next Pray'**
  String get nextPray;

  /// No description provided for @azkarSectionHeader.
  ///
  /// In en, this message translates to:
  /// **'Azkar'**
  String get azkarSectionHeader;

  /// No description provided for @morningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Morning Azkar'**
  String get morningAzkar;

  /// No description provided for @eveningAzkar.
  ///
  /// In en, this message translates to:
  /// **'Evening Azkar'**
  String get eveningAzkar;

  /// No description provided for @wakingUpAzkar.
  ///
  /// In en, this message translates to:
  /// **'Waking Up Azkar'**
  String get wakingUpAzkar;

  /// No description provided for @adhanAzkar.
  ///
  /// In en, this message translates to:
  /// **'Adhan Azkar'**
  String get adhanAzkar;

  /// No description provided for @afterPrayerAzkar.
  ///
  /// In en, this message translates to:
  /// **'After Prayer Azkar'**
  String get afterPrayerAzkar;

  /// No description provided for @sleepingAzkar.
  ///
  /// In en, this message translates to:
  /// **'Sleeping Azkar'**
  String get sleepingAzkar;

  /// No description provided for @recitationHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Voice Recitation Guide'**
  String get recitationHelpTitle;

  /// No description provided for @recitationHelpMessage.
  ///
  /// In en, this message translates to:
  /// **'1. Choose the Surah and the range of Ayahs you want to recite.\n\n2. Read the displayed Ayahs and review them carefully.\n\n3. Tap the microphone button to start recitation.\n\n4. Try to recite clearly and carefully.\n\n5. Tap Finish Recitation to view your review report and see correct, incorrect, and missing words.'**
  String get recitationHelpMessage;

  /// No description provided for @dialogOkButton.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get dialogOkButton;

  /// No description provided for @searchSurahHint.
  ///
  /// In en, this message translates to:
  /// **'Search by Surah name or Juz...'**
  String get searchSurahHint;

  /// No description provided for @recitationMode.
  ///
  /// In en, this message translates to:
  /// **'Recitation mode'**
  String get recitationMode;

  /// No description provided for @recording.
  ///
  /// In en, this message translates to:
  /// **'Recording'**
  String get recording;

  /// No description provided for @listenToAyah.
  ///
  /// In en, this message translates to:
  /// **'Listen to the ayah'**
  String get listenToAyah;

  /// No description provided for @finishRecitation.
  ///
  /// In en, this message translates to:
  /// **'Finish recitation'**
  String get finishRecitation;

  /// No description provided for @showMore.
  ///
  /// In en, this message translates to:
  /// **'Show more'**
  String get showMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'No Internet Connection'**
  String get networkError;

  /// No description provided for @timeoutError.
  ///
  /// In en, this message translates to:
  /// **'Request timed out'**
  String get timeoutError;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get serverError;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// No description provided for @badRequest.
  ///
  /// In en, this message translates to:
  /// **'Invalid request'**
  String get badRequest;

  /// No description provided for @unauthorized.
  ///
  /// In en, this message translates to:
  /// **'Unauthorized access'**
  String get unauthorized;

  /// No description provided for @forbidden.
  ///
  /// In en, this message translates to:
  /// **'Access denied'**
  String get forbidden;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Requested resource not found'**
  String get notFound;

  /// No description provided for @conflict.
  ///
  /// In en, this message translates to:
  /// **'Request conflict'**
  String get conflict;

  /// No description provided for @validationError.
  ///
  /// In en, this message translates to:
  /// **'Invalid data'**
  String get validationError;

  /// No description provided for @tooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many requests, please try again later'**
  String get tooManyRequests;

  /// No description provided for @serviceUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Service temporarily unavailable'**
  String get serviceUnavailable;

  /// No description provided for @cacheError.
  ///
  /// In en, this message translates to:
  /// **'Cache Error'**
  String get cacheError;

  /// No description provided for @requestCancelled.
  ///
  /// In en, this message translates to:
  /// **'Request was cancelled'**
  String get requestCancelled;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @selectSurahFirst.
  ///
  /// In en, this message translates to:
  /// **'Please select a Surah first'**
  String get selectSurahFirst;

  /// No description provided for @noAyahsFound.
  ///
  /// In en, this message translates to:
  /// **'No Ayahs found in the selected range.'**
  String get noAyahsFound;

  /// No description provided for @listeningStatus.
  ///
  /// In en, this message translates to:
  /// **'Listening...'**
  String get listeningStatus;

  /// No description provided for @readyToRecite.
  ///
  /// In en, this message translates to:
  /// **'Ready to recite. Tap the microphone to start.'**
  String get readyToRecite;

  /// No description provided for @speechUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Speech recognition service is currently unavailable'**
  String get speechUnavailable;

  /// No description provided for @speechRecognitionError.
  ///
  /// In en, this message translates to:
  /// **'An error occurred during speech recognition. Please try again'**
  String get speechRecognitionError;

  /// No description provided for @somethingWentWrongTitle.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrongTitle;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @suggested.
  ///
  /// In en, this message translates to:
  /// **'Suggested'**
  String get suggested;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
