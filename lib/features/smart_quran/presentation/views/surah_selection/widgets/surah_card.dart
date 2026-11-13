import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/domain/entities/surah.dart';

class SurahCard extends StatelessWidget {
  final Surah surah;
  final bool isSelected;
  final VoidCallback onTap;

  const SurahCard({
    super.key,
    required this.surah,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final int progress = surah.progress;
    final String surahName = surah.name;
    final String surahType = surah.typeArabic;
    final String verses = surah.numberOfAyahs.toString();

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(12.dg),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primary.withValues(alpha: 0.10)
                : AppColors.black.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.white.withValues(alpha: 0.13),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Text(
                  '${surah.number}',
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      surahName,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '$surahType • ${l10n.ayahCount(verses)}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    if (progress > 0) ...[
                      SizedBox(height: 8.h),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5.r),
                        child: LinearProgressIndicator(
                          value: progress / 100,
                          minHeight: 3,
                          backgroundColor: AppColors.white.withValues(
                            alpha: 0.1,
                          ),
                          valueColor: const AlwaysStoppedAnimation(
                            AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isSelected)
                    Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                      size: 20.sp,
                    )
                  else
                    Text(
                      progress > 0 ? '$progress٪' : l10n.notStartedYet,
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  SizedBox(height: 5.h),
                  Icon(
                    Icons.chevron_left_rounded,
                    color: AppColors.primary.withValues(alpha: 0.8),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
