import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';
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
        padding: EdgeInsets.all(AppSizes.size14W),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.radius22),
          border: Border.all(color: AppColors.primary.withValues(alpha: 0.45)),
          gradient: RadialGradient(
            center: Alignment(0, -AppSizes.size1_7H),
            radius: AppSizes.size1_5w,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AccuracyRing(
                      percent: percentage / 100,
                      label: '${_toArabicDigits('$percentage')}٪',
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(
                          start: AppSizes.size20W,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppSizes.size8W,
                                vertical: AppSizes.size4H,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.radius20,
                                ),
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
                            SizedBox(height: AppSizes.size8H),
                            Text(
                              report.surahName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.body18.copyWith(
                                color: AppColors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppSizes.size5H),
                            Text(
                              'الآيات ${_toArabicDigits('${report.startAyah}')} - '
                              '${_toArabicDigits('${report.endAyah}')}',
                              style: AppTextStyles.body10.copyWith(
                                color: AppColors.white.withValues(alpha: 0.75),
                              ),
                            ),
                            SizedBox(height: AppSizes.size5H),
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
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.size16H),
                Container(
                  height: 1,
                  color: AppColors.primary.withValues(alpha: 0.3),
                ),
                SizedBox(height: AppSizes.size12H),
                SizedBox(
                  height: AppSizes.size76H,
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
                      SizedBox(width: AppSizes.size7W),
                      Expanded(
                        child: ReportStatBox(
                          style: ReportStatBoxStyle.highlighted,
                          title: 'كلمات خاطئة',
                          value: _toArabicDigits('$incorrectCount'),
                          description: 'تحتاج مراجعة',
                        ),
                      ),
                      SizedBox(width: AppSizes.size7W),
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
                offset: Offset(AppSizes.size5W, -AppSizes.size5H),
                child: const ReportDiamond(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Transform.translate(
                offset: Offset(-AppSizes.size5W, -AppSizes.size5H),
                child: const ReportDiamond(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
