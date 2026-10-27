import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class CustomActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPressed;
  final bool isPrimary;
  final bool isEnabled;

  const CustomActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    this.isPrimary = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final buttonStyle = isPrimary
        ? ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: AppColors.black,
            disabledBackgroundColor: AppColors.progressBackground,
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          )
        : OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: BorderSide(color: AppColors.primary.withValues(alpha: 0.6)),
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 14.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.r),
            ),
          );

    return SizedBox(
      width: double.infinity,
      child: isPrimary
          ? ElevatedButton.icon(
              onPressed: isEnabled ? onPressed : null,
              icon: Icon(icon, size: 20.sp),
              label: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.body16.copyWith(color: AppColors.black),
              ),
              style: buttonStyle,
            )
          : OutlinedButton.icon(
              onPressed: isEnabled ? onPressed : null,
              icon: Icon(icon, size: 20.sp),
              label: Text(
                title,
                textAlign: TextAlign.center,
                style: AppTextStyles.body16,
              ),
              style: buttonStyle,
            ),
    );
  }
}
