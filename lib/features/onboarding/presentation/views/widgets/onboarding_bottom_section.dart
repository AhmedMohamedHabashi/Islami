import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_button.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_indicator.dart';

class OnboardingBottomSection extends StatelessWidget {
  const OnboardingBottomSection({
    super.key,
    required this.animation,
    required this.currentIndex,
    required this.itemCount,
    required this.onBack,
    required this.onNext,
  });

  final Animation<double> animation;
  final int currentIndex;
  final int itemCount;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          OnboardingIndicator(currentIndex: currentIndex, itemCount: itemCount),
          SizedBox(height: 25.h),
          OnboardingButtons(
            currentIndex: currentIndex,
            itemCount: itemCount,
            onBack: onBack,
            onNext: onNext,
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
