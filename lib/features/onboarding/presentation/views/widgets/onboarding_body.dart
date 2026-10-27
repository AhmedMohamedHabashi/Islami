import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/onboarding/domain/entities/onboarding_model.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_header.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_page.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_indicator.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_button.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_language_switch.dart';

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    super.key,
    required this.animation,
    required this.slideAnimation,
    required this.currentIndex,
    required this.pages,
    required this.pageController,
    required this.onPageChanged,
    required this.onBack,
    required this.onNext,
  });

  final Animation<double> animation;
  final Animation<Offset> slideAnimation;
  final int currentIndex;
  final List<OnboardingModel> pages;
  final PageController pageController;
  final ValueChanged<int> onPageChanged;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: slideAnimation,
                child: const OnboardingHeader(),
              ),
            ),
            SizedBox(height: 20.h),

            Expanded(
              child: FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: slideAnimation,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: pages.length,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      return OnboardingPage(page: pages[index]);
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            FadeTransition(
              opacity: animation,
              child: OnboardingIndicator(
                currentIndex: currentIndex,
                itemCount: pages.length,
              ),
            ),

            SizedBox(height: 25.h),

            FadeTransition(
              opacity: animation,
              child: OnboardingButtons(
                currentIndex: currentIndex,
                itemCount: pages.length,
                onBack: onBack,
                onNext: onNext,
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),

        OnboardingLanguageSwitch(visible: currentIndex == 0),
      ],
    );
  }
}
