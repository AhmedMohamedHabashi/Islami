import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/home/presentation/constants/home_strings.dart';

class HomeSearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const HomeSearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      cursorColor: AppColors.primary,
      style: AppTextStyles.body14.copyWith(color: AppColors.white),
      decoration: InputDecoration(
        hintText: HomeStrings.suraName,
        hintStyle: AppTextStyles.body14.copyWith(color: AppColors.white),
        prefixIcon: const Icon(
          Icons.menu_book_rounded,
          color: AppColors.primary,
        ),
        filled: true,
        fillColor: AppColors.primaryBackground.withValues(alpha: 0.6),
        contentPadding: EdgeInsets.symmetric(vertical: 14.h),
        enabledBorder: _border(),
        focusedBorder: _border(),
      ),
    );
  }

  OutlineInputBorder _border() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(12.r),
    borderSide: const BorderSide(color: AppColors.primary),
  );
}
