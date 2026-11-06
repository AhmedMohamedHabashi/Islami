import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

import 'ayah_card/ayah_card_corner.dart';
import 'ayah_card/ayah_card_footer.dart';
import 'ayah_card/ayah_card_header.dart';
import 'ayah_card/ayah_card_text.dart';

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
          // Golden corners.
          const Positioned(
            top: 0,
            left: 0,
            child: AyahCardCorner(quarterTurns: 0),
          ),

          const Positioned(
            top: 0,
            right: 0,
            child: AyahCardCorner(quarterTurns: 1),
          ),

          const Positioned(
            bottom: 0,
            left: 0,
            child: AyahCardCorner(quarterTurns: 3),
          ),

          const Positioned(
            bottom: 0,
            right: 0,
            child: AyahCardCorner(quarterTurns: 2),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AyahCardHeader(surahName: surahName),

                SizedBox(height: 5.h),

                AyahCardText(
                  ayahText: ayahText,
                  highlightedWord: highlightedWord,
                ),

                SizedBox(height: 5.h),

                AyahCardFooter(ayahNumber: ayahNumber),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
