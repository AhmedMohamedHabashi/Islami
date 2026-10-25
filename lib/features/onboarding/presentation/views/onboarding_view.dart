import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
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

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  bool get _isFirst => _currentIndex == 0;
  bool get _isLast => _currentIndex == onboardingList.length - 1;

  void _next() {
    if (_isLast) {
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _back() {
    _controller.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n= AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor:AppColors.primaryBackground,
      body: SafeArea(
        child: Column(
          children: [
            const OnboardingHeader(),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: onboardingList.length,
                onPageChanged: (index) =>
                    setState(() => _currentIndex = index),
                itemBuilder: (context, index) =>
                 OnboardingPage(
                    model: onboardingList[index],
                     index: index,
)              ),
            ),
 Padding(
  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  child: Directionality(
    textDirection: TextDirection.ltr,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 70,
          child: _isFirst
              ? null
              : OnboardingButton(text:l10n.back, onTap: _back),
        ),
        OnboardingIndicator(
          currentIndex: _currentIndex,
          count: onboardingList.length,
        ),
        SizedBox(
          width: 70,
          child: OnboardingButton(
            text: _isLast ?l10n.finish : l10n.next,
            onTap: _next,
          ),
        ),
      ],
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}