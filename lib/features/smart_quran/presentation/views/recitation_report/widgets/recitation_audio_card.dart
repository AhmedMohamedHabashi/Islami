import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class RecitationAudioCard extends StatelessWidget {
  final String title;
  final String text;
  final String? hint;
  final bool isHighlighted;
  final bool isPlaying;
  final VoidCallback onPlayTap;

  const RecitationAudioCard({
    super.key,
    required this.title,
    required this.text,
    required this.onPlayTap,
    this.hint,
    this.isHighlighted = false,
    this.isPlaying = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.size10W),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(AppSizes.size16W),
        border: Border.all(
          color: isHighlighted
              ? AppColors.primary
              : AppColors.white.withValues(alpha: 0.12),
          width: isHighlighted ? AppSizes.size1_7w : AppSizes.size1W,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.body10.copyWith(
              color: AppColors.white.withValues(alpha: 0.75),
            ),
          ),
          SizedBox(height: AppSizes.size8H),
          Row(
            children: [
              InkWell(
                onTap: onPlayTap,
                customBorder: const CircleBorder(),
                child: Container(
                  width: AppSizes.size34W,
                  height: AppSizes.size34H,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: AppColors.black,
                    size: AppSizes.icon20,
                  ),
                ),
              ),
              SizedBox(width: AppSizes.size8W),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: AppTextStyles.body16.copyWith(
                        color: AppColors.white,
                        height: AppSizes.size1_7H,
                      ),
                    ),
                    if (hint != null)
                      Text(
                        hint!,
                        style: AppTextStyles.body10.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
