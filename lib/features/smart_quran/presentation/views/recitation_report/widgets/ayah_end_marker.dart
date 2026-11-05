import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class AyahEndMarker extends StatelessWidget {
  final int ayahNumber;

  const AyahEndMarker({super.key, required this.ayahNumber});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.w,
      height: 30.h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.7)),
      ),
      child: Text(
        _toArabicDigits(ayahNumber),
        style: AppTextStyles.body12.copyWith(color: AppColors.primary),
      ),
    );
  }

  static String _toArabicDigits(int number) {
    const digits = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    return number.toString().split('').map((d) => digits[int.parse(d)]).join();
  }
}
