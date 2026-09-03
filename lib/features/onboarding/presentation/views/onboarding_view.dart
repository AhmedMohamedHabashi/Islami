import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/onboarding/data/models/onboarding_data.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_button.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_header.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_indicator.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_page.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;

  int currentIndex = 0;

  late AnimationController _animationController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void nextPage() {
    final pages = OnboardingPages.getPages(AppLocalizations.of(context)!);

    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      // Navigate Home later
    }
  }

  void backPage() {
    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final pages = OnboardingPages.getPages(locale);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,

      body: SafeArea(
        child: Column(
          children: [
            FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: const OnboardingHeader(),
              ),
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: pages.length,

                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },

                    itemBuilder: (context, index) {
                      return OnboardingPage(page: pages[index]);
                    },
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            FadeTransition(
              opacity: _fadeAnimation,
              child: OnboardingIndicator(
                currentIndex: currentIndex,
                itemCount: pages.length,
              ),
            ),

            SizedBox(height: 25.h),

            FadeTransition(
              opacity: _fadeAnimation,
              child: OnboardingButtons(
                currentIndex: currentIndex,
                itemCount: pages.length,
                onBack: backPage,
                onNext: nextPage,
              ),
            ),

            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
