import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class SurahContinueCard extends StatelessWidget {
  const SurahContinueCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.55)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.15),
            blurRadius: 12.sp,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.circle, color: AppColors.primary, size: 7.sp),
              SizedBox(width: 6.h),
              Expanded(
                child: Text(
                  'الورد اليومي - التسميع',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: AppColors.primary),
                ),
              ),
              _buildBadge('٧ أيام متتالية'),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            'سورة الكهف • الآيات ١ - ١٥',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Text(
                'نسبة الإنجاز الحالية',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.white.withValues(alpha: 0.6),
                ),
              ),
              const Spacer(),
              Text(
                '٨٥٪',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 7.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: const LinearProgressIndicator(
              value: 0.85,
              minHeight: 4,
              backgroundColor: AppColors.progressBackground,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ),
          SizedBox(height: 14.h),
          ElevatedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.play_arrow_rounded, size: 21.sp),
            label: const Text('متابعة الحفظ الآن'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.black,
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: 13.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: AppTextStyles.regular.copyWith(color: AppColors.primary),
      ),
    );
  }
}
