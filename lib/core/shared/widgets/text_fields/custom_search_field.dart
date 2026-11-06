import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.hintText,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!.localeName;

    final textDirection = locale == 'ar'
        ? TextDirection.rtl
        : TextDirection.ltr;

    return Directionality(
      textDirection: textDirection,
      child: TextField(
        cursorColor: AppColors.primary,
        controller: controller,
        onChanged: onChanged,
        textDirection: textDirection,
        textAlign: TextAlign.start,
        style: const TextStyle(color: AppColors.white),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTextStyles.regular.copyWith(
            color: AppColors.white.withValues(alpha: 0.45),
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.primary,
            size: 20.sp,
          ),
          filled: true,
          fillColor: AppColors.black.withValues(alpha: 0.22),
          contentPadding: EdgeInsets.symmetric(
            vertical: 12.h,
            horizontal: 12.w,
          ),
          border: _buildBorder(),
          enabledBorder: _buildBorder(),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: AppColors.white.withValues(alpha: 0.15)),
    );
  }
}
