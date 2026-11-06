import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class AyahCardFooter extends StatelessWidget {
  final int ayahNumber;

  const AyahCardFooter({super.key, required this.ayahNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Bottom decoration.
        Row(
          children: [
            Expanded(child: _goldLine()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: Icon(
                Icons.diamond_outlined,
                color: AppColors.primary,
                size: 15.sp,
              ),
            ),
            Expanded(child: _goldLine()),
          ],
        ),

        SizedBox(height: 5.h),

        // Ayah information.
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
    );
  }

  Widget _goldLine() {
    return Container(
      height: 1.h,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.55),
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}
