import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';
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
      borderRadius: BorderRadius.circular(AppSizes.radius14),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppSizes.size10W : AppSizes.size4W,
          vertical: isSelected ? AppSizes.size8H : AppSizes.size2H,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.08)
              : AppColors.transparent,
          borderRadius: BorderRadius.circular(AppSizes.radius14),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.transparent,
            width: AppSizes.size1W,
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
                height: AppSizes.size1H,
              ),
            ),
            if (isSelected && _hasIssue) ...[
              SizedBox(width: AppSizes.size8W),
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
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.size8W,
        vertical: AppSizes.size4H,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(AppSizes.radius10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.warning_amber_rounded,
            size: AppSizes.icon12,
            color: AppColors.black,
          ),
          SizedBox(width: AppSizes.size4W),
          Text(
            'تنبيه',
            style: AppTextStyles.body10.copyWith(
              color: AppColors.black,
              height: AppSizes.size1H,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
