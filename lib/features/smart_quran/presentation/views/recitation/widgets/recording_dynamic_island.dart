import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecordingDynamicIsland extends StatelessWidget {
  final bool isRecording;

  const RecordingDynamicIsland({super.key, this.isRecording = false});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: AppColors.ayahCardGradientBottom,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: isRecording
              ? AppColors.primary.withValues(alpha: 0.55)
              : AppColors.primary.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: isRecording ? Colors.redAccent : AppColors.primary,
              shape: BoxShape.circle,
              boxShadow: isRecording
                  ? [
                      BoxShadow(
                        color: Colors.redAccent.withValues(alpha: 0.4),
                        blurRadius: 8.r,
                        spreadRadius: 1.r,
                      ),
                    ]
                  : null,
            ),
          ),
          SizedBox(width: 8.w),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 250),
            style: AppTextStyles.body10.copyWith(
              color: isRecording ? AppColors.white : AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
            child: Text(isRecording ? 'جاري التسجيل' : 'وضع التسميع'),
          ),
        ],
      ),
    );
  }
}
