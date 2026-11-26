import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/home/domain/entities/surah_entity.dart';
import 'package:islami/features/home/presentation/constants/home_strings.dart';
import 'package:islami/features/home/presentation/views/widgets/recent_surah_card.dart';

class RecentSurahsSection extends StatelessWidget {
  final List<SurahEntity> surahs;

  const RecentSurahsSection({super.key, required this.surahs});

  @override
  Widget build(BuildContext context) {
    if (surahs.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          HomeStrings.mostRecently,
          style: AppTextStyles.body16.copyWith(
            color: AppColors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 10.h),
        SizedBox(
          height: 150.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: surahs.length,
            separatorBuilder: (_, _) => SizedBox(width: 12.w),
            itemBuilder: (_, i) => RecentSurahCard(surah: surahs[i]),
          ),
        ),
        SizedBox(height: 16.h),
      ],
    );
  }
}
