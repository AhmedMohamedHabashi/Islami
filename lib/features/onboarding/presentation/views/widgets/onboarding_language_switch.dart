import 'package:flutter/material.dart';
import 'package:islami/config/localization/widgets/language_switch.dart';
import 'package:islami/core/utils/app_sizes.dart';

class OnboardingLanguageSwitch extends StatelessWidget {
  const OnboardingLanguageSwitch({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return PositionedDirectional(
      top: AppSizes.size8H,
      end: AppSizes.size8W,
      child: const LanguageSwitch(),
    );
  }
}
