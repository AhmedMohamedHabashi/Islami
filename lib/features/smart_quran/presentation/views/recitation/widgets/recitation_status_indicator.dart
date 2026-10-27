import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecitationStatusIndicator extends StatelessWidget {
  final String statusText;
  final bool isLoading;

  const RecitationStatusIndicator({
    super.key,
    required this.statusText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Row(
        key: ValueKey('$statusText-$isLoading'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            SizedBox(
              width: 16.w,
              height: 16.w,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                color: AppColors.primary,
              ),
            ),
            SizedBox(width: 10.w),
          ] else ...[
            Icon(
              Icons.info_outline_rounded,
              size: 18.sp,
              color: AppColors.primary.withValues(alpha: 0.75),
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Text(
              statusText,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(
                color: AppColors.primary.withValues(alpha: 0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
