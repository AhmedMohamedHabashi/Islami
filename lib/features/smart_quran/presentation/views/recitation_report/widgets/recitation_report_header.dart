import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecitationReportHeader extends StatelessWidget {
  const RecitationReportHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.diamond_outlined, color: AppColors.primary, size: 20.sp),
        SizedBox(width: 8.w),
        Text(
          'تحليل التسميع كلمة بكلمة',
          style: AppTextStyles.body14.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Spacer(),
        Text(
          'اضغط على الكلمة للاستماع',
          style: AppTextStyles.body10.copyWith(
            color: AppColors.white.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}
