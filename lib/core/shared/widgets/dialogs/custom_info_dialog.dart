import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class CustomInfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onPressed;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Dialog(
      backgroundColor: AppColors.transparent,
      elevation: 0,
      insetPadding: EdgeInsets.symmetric(horizontal: 28.w),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(context).height * 0.82,
        ),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: AppColors.ayahCardGradientTop,
          borderRadius: BorderRadius.circular(25.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.35),
            width: 1.w,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.3),
              blurRadius: 30.r,
              offset: const Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.10),
                border: Border.all(
                  color: AppColors.primary.withValues(alpha: 0.35),
                  width: 1.2.w,
                ),
              ),
              child: Icon(
                Icons.info_outline_rounded,
                color: AppColors.primary,
                size: 34.sp,
              ),
            ),

            SizedBox(height: 10.h),

            Text(
              title,
              textAlign: TextAlign.center,
              style: AppTextStyles.body18.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 10.h),

            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.primary,
                    size: 16.sp,
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 1.h,
                    color: AppColors.primary.withValues(alpha: 0.25),
                  ),
                ),
              ],
            ),

            SizedBox(height: 10.h),

            Flexible(
              child: SingleChildScrollView(
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.white.withValues(alpha: 0.8),
                    height: 1.5.h,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20.h),

            CustomActionButton(
              title: buttonText ?? l10n.dialogOkButton,
              icon: Icons.check_rounded,
              onPressed: onPressed ?? () => context.pop(),
              isPrimary: true,
            ),
          ],
        ),
      ),
    );
  }
}
