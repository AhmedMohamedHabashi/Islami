import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class RecitationStatusLegend extends StatelessWidget {
  const RecitationStatusLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSizes.size8W,
      runSpacing: AppSizes.size8H,
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
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.size10W,
        vertical: AppSizes.size6H,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppSizes.radius10),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: AppSizes.icon14, color: color),
          SizedBox(width: AppSizes.size4W),
          Text(
            label,
            style: AppTextStyles.body10.copyWith(color: AppColors.white),
          ),
        ],
      ),
    );
  }
}
