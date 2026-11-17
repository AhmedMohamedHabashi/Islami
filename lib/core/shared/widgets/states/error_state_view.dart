import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class ErrorStateView extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const ErrorStateView({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            Container(
              width: 104.w,
              height: 104.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBackground.withValues(alpha: 0.12),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.3),
                  width: 1.5.w,
                ),
              ),
              child: Icon(icon, size: 48.sp, color: AppColors.white),
            ),

            SizedBox(height: 28.h),

            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body20.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 12.h),

            // Error Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
                height: 1.7.h,
              ),
            ),

            SizedBox(height: 32.h),

            // Retry Button
            SizedBox(
              width: 220.w,
              child: CustomActionButton(
                title: retryLabel,
                icon: Icons.refresh_rounded,
                onPressed: onRetry,
                isPrimary: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
