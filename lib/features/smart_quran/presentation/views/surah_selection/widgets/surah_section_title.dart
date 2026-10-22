import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class SurahSectionTitle extends StatelessWidget {
  final int surahCount;

  const SurahSectionTitle({super.key, required this.surahCount});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Icon(Icons.auto_stories, color: AppColors.primary, size: 18.sp),
        SizedBox(width: 7.w),
        Expanded(
          child: Text(
            l10n.quranSurahsTitle,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          l10n.surahCount(surahCount),
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.white.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}
