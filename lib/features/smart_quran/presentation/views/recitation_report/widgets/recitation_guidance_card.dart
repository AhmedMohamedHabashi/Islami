import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import '../../../../domain/entities/recitation_report.dart';

class RecitationGuidanceCard extends StatelessWidget {
  final RecitationGuidance guidance;

  const RecitationGuidanceCard({super.key, required this.guidance});

  IconData get _icon => switch (guidance.type) {
    RecitationGuidanceType.tajweedRule => Icons.menu_book_rounded,
    RecitationGuidanceType.repetitionSchedule => Icons.hourglass_bottom_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  guidance.title,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  guidance.description,
                  style: AppTextStyles.body12.copyWith(
                    color: AppColors.white.withValues(alpha: 0.6),
                    height: 1.6.h,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Icon(_icon, color: AppColors.primary, size: 20.sp),
          ),
        ],
      ),
    );
  }
}
