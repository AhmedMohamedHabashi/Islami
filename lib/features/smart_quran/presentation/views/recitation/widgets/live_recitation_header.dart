import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

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
    final indicatorColor = isRecording
        ? AppColors.incorrectWord
        : AppColors.primary;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppSizes.size12H),
      decoration: BoxDecoration(
        color: AppColors.ayahCardGradientBottom,
        borderRadius: BorderRadius.circular(AppSizes.radius16),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.35),
          width: AppSizes.size1W,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: AppSizes.size8W,
                  height: AppSizes.size8H,
                  decoration: BoxDecoration(
                    color: indicatorColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: indicatorColor.withValues(alpha: 0.4),
                        blurRadius: isRecording ? AppSizes.size8W : 0,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: AppSizes.size8W),
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
          SizedBox(width: AppSizes.size12W),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppSizes.size8W,
              vertical: AppSizes.size4H,
            ),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(AppSizes.radius12),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.35),
                width: AppSizes.size1W,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.access_time_rounded,
                  color: AppColors.primary,
                  size: AppSizes.icon16,
                ),
                SizedBox(width: AppSizes.size6W),
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
