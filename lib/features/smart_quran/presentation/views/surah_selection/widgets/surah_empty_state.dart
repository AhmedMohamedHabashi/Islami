import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class SurahEmptyState extends StatelessWidget {
  const SurahEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 40.sp,
            color: AppColors.primary.withValues(alpha: 0.7),
          ),
          SizedBox(height: 10.h),
          Text(
            'لا توجد سور مطابقة',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.white.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }
}
