
import 'package:flutter/material.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/onboarding/data/models/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({
    super.key,
    required this.model,
    required this.index,
  });

  final OnboardingModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final titles = [
      l10n.welcome,
      l10n.welcomeTitle,
      l10n.readingTitle,
      l10n.azkarTitle,
      l10n.radioTitle,
    ];

    final descriptions = [
      '',
      l10n.welcomeDescription,
      l10n.readingDescription,
      l10n.azkarDescription,
      l10n.radioDescription,
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(
              model.image,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            titles[index],
            textAlign: TextAlign.center,
            style: AppTextStyles.heading2.copyWith(
              color: AppColors.primary,
            ),
          ),
          if (descriptions[index].isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              descriptions[index],
              textAlign: TextAlign.center,
              style: AppTextStyles.body16.copyWith(
                color: AppColors.primary,
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
