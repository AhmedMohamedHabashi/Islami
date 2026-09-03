import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/features/onboarding/domain/entities/onboarding_model.dart';

class OnboardingPages {
  static List<OnboardingModel> getPages(AppLocalizations locale) {
    return [
      OnboardingModel(image: AppAssets.welcome, title: locale.welcomeTitle),
      OnboardingModel(
        image: AppAssets.onboarding4,
        title: locale.welcomeTitle,
        description: locale.welcomeDescription,
      ),
      OnboardingModel(
        image: AppAssets.onboarding2,
        title: locale.readingTitle,
        description: locale.readingDescription,
      ),
      OnboardingModel(
        image: AppAssets.onboarding5,
        title: locale.azkarTitle,
        description: locale.azkarDescription,
      ),

      OnboardingModel(
        image: AppAssets.onboarding3,
        title: locale.radioTitle,
        description: locale.radioDescription,
      ),
    ];
  }
}
