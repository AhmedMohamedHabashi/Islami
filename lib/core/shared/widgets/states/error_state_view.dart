import 'package:flutter/material.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class ErrorStateView extends StatelessWidget {
  final IconData icon;
  final String? title;
  final String message;
  final String retryLabel;
  final VoidCallback onRetry;

  const ErrorStateView({
    super.key,
    required this.icon,
    this.title,
    required this.message,
    required this.retryLabel,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.size28W),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Error Icon
            Container(
              width: AppSizes.size104W,
              height: AppSizes.size104H,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryBackground.withValues(alpha: 0.12),
                border: Border.all(
                  color: AppColors.white.withValues(alpha: 0.3),
                  width: AppSizes.size1_5w,
                ),
              ),
              child: Icon(icon, size: AppSizes.icon48, color: AppColors.white),
            ),

            SizedBox(height: AppSizes.size28H),

            // Optional Title
            if (title != null) ...[
              Text(
                title!,
                textAlign: TextAlign.center,
                style: AppTextStyles.body20.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppSizes.size12H),
            ],

            // Error Message
            Text(
              message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(
                color: AppColors.white.withValues(alpha: 0.7),
                height: AppSizes.size1_7H,
              ),
            ),

            SizedBox(height: AppSizes.size32H),

            // Retry Button
            SizedBox(
              width: AppSizes.size220W,
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
