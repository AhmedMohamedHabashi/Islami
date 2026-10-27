import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/widgets/language_switch.dart';

class OnboardingLanguageSwitch extends StatelessWidget {
  const OnboardingLanguageSwitch({super.key, required this.visible});

  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return const SizedBox.shrink();
    }

    return PositionedDirectional(
      top: 8.h,
      end: 8.w,
      child: const LanguageSwitch(),
    );
  }
}
