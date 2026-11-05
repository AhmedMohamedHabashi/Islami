import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

import '../../../../domain/entities/recitation_report.dart';

class RecitationWordChip extends StatelessWidget {
  final RecitationWord word;
  final bool isSelected;
  final VoidCallback onTap;

  const RecitationWordChip({
    super.key,
    required this.word,
    required this.isSelected,
    required this.onTap,
  });

  Color get _textColor => switch (word.status) {
    RecitationWordStatus.correct => AppColors.white,
    RecitationWordStatus.warning => AppColors.primary,
    RecitationWordStatus.missing => AppColors.missingWord,
  };

  bool get _hasIssue => word.status != RecitationWordStatus.correct;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? 10.w : 4.w,
          vertical: isSelected ? 8.h : 2.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.transparent,
            width: 1.5.w,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              word.text,
              style: AppTextStyles.body18.copyWith(
                fontWeight: FontWeight.w700,
                color: _textColor,
                height: 1.h,
              ),
            ),
            if (isSelected && _hasIssue) ...[
              SizedBox(width: 8.w),
              const _AlertBadge(),
            ],
          ],
        ),
      ),
    );
  }
}

class _AlertBadge extends StatelessWidget {
  const _AlertBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: 12.sp,
            color: AppColors.black,
          ),
          SizedBox(width: 4.w),
          Text(
            'تنبيه',
            style: AppTextStyles.body10.copyWith(
              color: AppColors.black,
              height: 1.h,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
