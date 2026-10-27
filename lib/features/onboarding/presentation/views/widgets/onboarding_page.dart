import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/onboarding/domain/entities/onboarding_model.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.page});

  final OnboardingModel page;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,

      builder: (context, value, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                Transform.translate(
                  offset: Offset(0, 40.h * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Image.asset(
                      page.image,
                      height: 240.h,
                      width: 300.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                SizedBox(height: 80.h),

                Transform.translate(
                  offset: Offset(0, 20.h * (1 - value)),
                  child: Opacity(
                    opacity: value,
                    child: Text(
                      page.title,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.heading1.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),

                if (page.description != null) ...[
                  SizedBox(height: 20.h),

                  Transform.translate(
                    offset: Offset(0, 30.h * (1 - value)),
                    child: Opacity(
                      opacity: value,
                      child: Text(
                        page.description!,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body20.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
