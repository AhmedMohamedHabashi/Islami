import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class CurrentAyahCard extends StatelessWidget {
  final String ayahText;
  final int ayahNumber;
  final String? surahName;
  final String? highlightedWord;

  const CurrentAyahCard({
    super.key,
    required this.ayahText,
    required this.ayahNumber,
    this.surahName = 'سورة الكهف',
    this.highlightedWord,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.ayahCardGradientTop,
            AppColors.ayahCardGradientMiddle,
            AppColors.ayahCardGradientBottom,
          ],
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: 0.5),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 18.r,
            spreadRadius: 1.r,
          ),
        ],
      ),
      child: Stack(
        children: [
          // الزوايا الذهبية الداخلية.
          Positioned(top: 0, left: 0, child: _buildCorner(0)),
          Positioned(top: 0, right: 0, child: _buildCorner(1)),
          Positioned(bottom: 0, left: 0, child: _buildCorner(3)),
          Positioned(bottom: 0, right: 0, child: _buildCorner(2)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // الزخرفة العلوية في منتصف الكارت.
                Padding(
                  padding: EdgeInsets.only(top: 12.h),
                  child: Row(
                    children: [
                      Expanded(child: _goldLine()),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Icon(
                          Icons.diamond_outlined,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                      ),
                      Expanded(child: _goldLine()),
                    ],
                  ),
                ),

                SizedBox(height: 5.h),

                // اسم السورة.
                Text(
                  surahName ?? 'سورة',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 5.h),

                // البسملة.
                Text(
                  'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: AppTextStyles.body20.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    height: 1.8,
                  ),
                ),

                SizedBox(height: 5.h),

                // نص الآية مع إمكانية تمييز كلمة.
                RichText(
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  text: TextSpan(
                    style: AppTextStyles.body24.copyWith(
                      color: AppColors.primary,
                    ),
                    children: _buildAyahSpans(),
                  ),
                ),

                SizedBox(height: 5.h),

                // الفاصل السفلي.
                Row(
                  children: [
                    Expanded(child: _goldLine(opacity: 0.55)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Icon(
                        Icons.diamond_outlined,
                        color: AppColors.primary,
                        size: 15.sp,
                      ),
                    ),
                    Expanded(child: _goldLine(opacity: 0.55)),
                  ],
                ),

                SizedBox(height: 5.h),

                // وصف صغير أسفل الآية.
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu_book_rounded,
                      color: AppColors.white.withValues(alpha: 0.65),
                      size: 14.sp,
                    ),
                    SizedBox(width: 6.w),
                    Flexible(
                      child: Text(
                        'الآية $ayahNumber • اقرأ بتأنٍّ وركّز في التلاوة',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.body12.copyWith(
                          color: AppColors.white.withValues(alpha: 0.65),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _goldLine({double opacity = 0.4}) {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }

  List<InlineSpan> _buildAyahSpans() {
    final word = highlightedWord;

    if (word == null || word.isEmpty) {
      return [TextSpan(text: ayahText)];
    }

    final start = ayahText.indexOf(word);

    if (start == -1) {
      return [TextSpan(text: ayahText)];
    }

    final end = start + word.length;

    return [
      if (start > 0) TextSpan(text: ayahText.substring(0, start)),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          decoration: BoxDecoration(
            color: AppColors.ayahCardGradientBottom,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.primary, width: 1.w),
          ),
          child: Text(
            word,
            style: AppTextStyles.body24.copyWith(
              color: AppColors.primary,
              height: 1.8.h,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      if (end < ayahText.length) TextSpan(text: ayahText.substring(end)),
    ];
  }

  Widget _buildCorner(int quarterTurns) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: Container(
        width: 14.w,
        height: 14.w,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.primary, width: 2.w),
            left: BorderSide(color: AppColors.primary, width: 2.w),
          ),
        ),
      ),
    );
  }
}
