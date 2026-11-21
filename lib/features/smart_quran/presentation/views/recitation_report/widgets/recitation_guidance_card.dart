import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';
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
      padding: EdgeInsets.all(AppSizes.size14W),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSizes.radius16),
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
                SizedBox(height: AppSizes.size6H),
                Text(
                  guidance.description,
                  style: AppTextStyles.body12.copyWith(
                    color: AppColors.white.withValues(alpha: 0.6),
                    height: AppSizes.size1_7H,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: AppSizes.size12W),
          Container(
            width: AppSizes.size38W,
            height: AppSizes.size38H,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.4),
              ),
            ),
            child: Icon(_icon, color: AppColors.primary, size: AppSizes.icon20),
          ),
        ],
      ),
    );
  }
}
