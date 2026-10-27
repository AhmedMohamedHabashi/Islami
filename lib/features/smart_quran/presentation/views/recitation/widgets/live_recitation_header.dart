import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class LiveRecitationHeader extends StatelessWidget {
  final String duration;
  final bool isRecording;

  const LiveRecitationHeader({
    super.key,
    required this.duration,
    this.isRecording = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.ayahCardGradientBottom,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
          width: 1.w,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: isRecording ? Colors.redAccent : AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    'تسميع صوتي مباشر',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body14.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // كونتينر الوقت الداخلي: نفس التصميم السابق.
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: AppColors.primary,
                  size: 16.sp,
                ),
                SizedBox(width: 6.w),
                Text(
                  duration,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
