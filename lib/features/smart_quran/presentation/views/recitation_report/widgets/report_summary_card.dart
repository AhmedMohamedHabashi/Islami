import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/smart_quran/domain/entities/recitation_report.dart';

import 'accuracy_ring.dart';
import 'report_card_decorations.dart';
import 'report_stat_box.dart';

class ReportSummaryCard extends StatelessWidget {
  final RecitationReport report;

  const ReportSummaryCard({super.key, required this.report});

  String _toArabicDigits(String input) {
    const english = '0123456789';
    const arabic = '٠١٢٣٤٥٦٧٨٩';

    for (var i = 0; i < english.length; i++) {
      input = input.replaceAll(english[i], arabic[i]);
    }

    return input;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = report.accuracyPercentage.clamp(0, 100);
    final incorrectCount = report.incorrectWordCount;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
          gradient: RadialGradient(
            center: Alignment(0, -2.r),
            radius: 1.3.r,
            colors: [
              AppColors.primary.withValues(alpha: 0.15),
              AppColors.primaryBackground,
              AppColors.ayahCardGradientBottom,
            ],
            stops: const [0, 0.55, 1],
          ),
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AccuracyRing(
                      percent: percentage / 100,
                      label: '${_toArabicDigits('$percentage')}٪',
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: AppColors.primary.withValues(
                                  alpha: 0.75,
                                ),
                              ),
                            ),
                            child: Text(
                              'تقييم الأداء: ${report.resultTitle}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body10.copyWith(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Text(
                            report.surahName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.body18.copyWith(
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'الآيات ${_toArabicDigits('${report.startAyah}')} - '
                            '${_toArabicDigits('${report.endAyah}')}',
                            style: AppTextStyles.body10.copyWith(
                              color: AppColors.white.withValues(alpha: 0.75),
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'عدد الكلمات الصحيحة: '
                            '${_toArabicDigits('${report.correctWordCount}')}',
                            style: AppTextStyles.body10.copyWith(
                              color: AppColors.white.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  height: 1,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
                SizedBox(height: 12.h),
                SizedBox(
                  height: 76.h,
                  child: Row(
                    children: [
                      Expanded(
                        child: ReportStatBox(
                          style: ReportStatBoxStyle.normal,
                          title: 'كلمات صحيحة',
                          value: _toArabicDigits('${report.correctWordCount}'),
                          description: 'أداء صحيح',
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: ReportStatBox(
                          style: ReportStatBoxStyle.highlighted,
                          title: 'كلمات خاطئة',
                          value: _toArabicDigits('$incorrectCount'),
                          description: 'تحتاج مراجعة',
                        ),
                      ),
                      SizedBox(width: 7.w),
                      Expanded(
                        child: ReportStatBox(
                          style: ReportStatBoxStyle.dashed,
                          title: 'كلمات ناقصة',
                          value: _toArabicDigits('${report.missingWordCount}'),
                          description: 'تحتاج إكمال',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Transform.translate(
                offset: Offset(5.w, -5.h),
                child: const ReportDiamond(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Transform.translate(
                offset: Offset(-5.w, -5.h),
                child: const ReportDiamond(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
