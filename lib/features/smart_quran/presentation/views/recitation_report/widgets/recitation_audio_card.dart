import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

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
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
        color: isHighlighted
            ? AppColors.primary.withValues(alpha: 0.08)
            : AppColors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isHighlighted
              ? AppColors.primary
              : AppColors.white.withValues(alpha: 0.12),
          width: isHighlighted ? 1.5.w : 1.w,
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
          SizedBox(height: 8.h),
          Row(
            children: [
              InkWell(
                onTap: onPlayTap,
                customBorder: const CircleBorder(),
                child: Container(
                  width: 34.w,
                  height: 34.h,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    color: AppColors.black,
                    size: 20.sp,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: AppTextStyles.body16.copyWith(
                        color: AppColors.white,
                        height: 1.5.h,
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
