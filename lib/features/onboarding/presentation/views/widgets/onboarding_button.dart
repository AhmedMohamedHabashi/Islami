import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class OnboardingButtons extends StatelessWidget {
  const OnboardingButtons({
    super.key,
    required this.currentIndex,
    required this.itemCount,
    required this.onBack,
    required this.onNext,
  });

  final int currentIndex;
  final int itemCount;
  final VoidCallback onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    final bool isLastPage = currentIndex == itemCount - 1;
    final bool isFirstPage = currentIndex == 0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirstPage)
            TextButton(
              onPressed: onBack,
              child: Text(
                locale.back,
                style: AppTextStyles.body16.copyWith(color: AppColors.primary),
              ),
            )
          else
            SizedBox(width: 70.w),

          TextButton(
            onPressed: onNext,
            child: Text(
              isLastPage ? locale.finish : locale.next,
              style: AppTextStyles.body16.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
