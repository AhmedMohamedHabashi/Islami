import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class SurahEmptyState extends StatelessWidget {
  const SurahEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Icon(
          Icons.search_off_rounded,
          size: 40.sp,
          color: AppColors.primary.withValues(alpha: 0.7),
        ),
        SizedBox(height: 10.h),
        Text(
          l10n.noMatchingSurahs,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: AppColors.white.withValues(alpha: 0.7),
          ),
        ),
      ],
    );
  }
}
