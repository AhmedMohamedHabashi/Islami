import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class AyahCardHeader extends StatelessWidget {
  final String? surahName;
  final bool showBasmala;

  const AyahCardHeader({super.key, this.surahName, this.showBasmala = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

        Text(
          surahName ?? 'سورة',
          textAlign: TextAlign.center,
          style: AppTextStyles.body14.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          ),
        ),

        if (showBasmala) ...[
          SizedBox(height: 5.h),
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
