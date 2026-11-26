import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/home/domain/entities/surah_entity.dart';
import 'package:islami/features/home/presentation/constants/home_strings.dart';
import 'package:islami/features/home/presentation/views/widgets/surah_number_badge.dart';

class SurahListItem extends StatelessWidget {
  final SurahEntity surah;
  final bool showDivider;

  const SurahListItem({
    super.key,
    required this.surah,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    final titleStyle = AppTextStyles.body16.copyWith(
      color: AppColors.white,
      fontWeight: FontWeight.w600,
    );

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            children: [
              SurahNumberBadge(number: surah.number),
              SizedBox(width: 18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(surah.nameEn, style: titleStyle),
                    SizedBox(height: 4.h),
                    Text(
                      '${surah.versesCount} ${HomeStrings.verses}',
                      style: AppTextStyles.body12.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                surah.nameAr,
                textDirection: TextDirection.rtl,
                style: titleStyle,
              ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(height: 1, thickness: 1, color: AppColors.white),
      ],
    );
  }
}
