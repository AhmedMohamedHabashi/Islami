import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/home/domain/entities/surah_entity.dart';
import 'package:islami/features/home/presentation/constants/home_assets.dart';
import 'package:islami/features/home/presentation/constants/home_strings.dart';

class RecentSurahCard extends StatelessWidget {
  final SurahEntity surah;

  const RecentSurahCard({super.key, required this.surah});

  @override
  Widget build(BuildContext context) {
    final nameStyle = AppTextStyles.heading2.copyWith(
      fontSize: 22.sp,
      fontWeight: FontWeight.w700,
      color: AppColors.black,
    );

    return Container(
      width: 280.w,
      padding: EdgeInsetsDirectional.fromSTEB(14.w, 14.h, 0, 14.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: Image.asset(HomeAssets.quranIllustration, width: 140.w),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(surah.nameEn, style: nameStyle),
                  SizedBox(height: 4.h),
                  Text(surah.nameAr, style: nameStyle),
                ],
              ),
              Text(
                '${surah.versesCount} ${HomeStrings.verses}',
                style: AppTextStyles.body12.copyWith(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
