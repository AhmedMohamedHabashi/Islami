import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class AyahCardHeader extends StatelessWidget {
  final String? surahName;
  final bool showBasmala;

  const AyahCardHeader({super.key, this.surahName, this.showBasmala = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: AppSizes.size12H),
          child: Row(
            children: [
              Expanded(child: _goldLine()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.size10W),
                child: Icon(
                  Icons.diamond_outlined,
                  color: AppColors.primary,
                  size: AppSizes.icon20,
                ),
              ),
              Expanded(child: _goldLine()),
            ],
          ),
        ),

        SizedBox(height: AppSizes.size5H),

        Text(
          surahName ?? 'سورة',
          textAlign: TextAlign.center,
          style: AppTextStyles.body14.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        if (showBasmala) ...[
          SizedBox(height: AppSizes.size5H),
          Text(
            'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ',
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: AppTextStyles.body20.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ],
    );
  }

  Widget _goldLine() {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}
