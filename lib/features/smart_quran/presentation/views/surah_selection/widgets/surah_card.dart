import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class SurahCard extends StatelessWidget {
  final Map<String, dynamic> surah;

  const SurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final progress = surah['progress'] as int;

    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.r),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('اخترت ${surah['name']}'),
              duration: const Duration(seconds: 1),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(12.dg),
          decoration: BoxDecoration(
            color: AppColors.black.withValues(alpha: 0.22),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.13)),
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
                  '${surah['number']}',
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
                      surah['name'] as String,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      '${surah['type']} • ${surah['verses']} آية',
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
                  Text(
                    progress > 0 ? '$progress٪' : 'لم تبدأ بعد',
                    style: Theme.of(
                      context,
                    ).textTheme.labelSmall?.copyWith(color: AppColors.primary),
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
