import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecitationStatusLegend extends StatelessWidget {
  const RecitationStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _LegendChip(
          label: 'نطق سليم',
          icon: Icons.check_rounded,
          color: AppColors.correctWord,
        ),
        _LegendChip(
          label: 'تنبيه تجويد / تردد',
          icon: Icons.warning_amber_rounded,
          color: AppColors.primary,
        ),
        _LegendChip(
          label: 'موضع متروك',
          icon: Icons.crop_square_rounded,
          color: AppColors.missingWord,
        ),
      ],
    );
  }
}

class _LegendChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _LegendChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.sp, color: color),
          SizedBox(width: 4.w),
          Text(
            label,
            style: AppTextStyles.body10.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
