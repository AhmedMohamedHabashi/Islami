import 'package:flutter/material.dart';
import '../colors/app_colors.dart';
import '../text_style/app_text_styles.dart';
import 'app_fonts.dart';

class AppTheme {
  static ThemeData lightTheme(String languageCode) {
    return ThemeData(
      useMaterial3: true,

      brightness: Brightness.light,

      fontFamily: languageCode == 'ar' ? AppFonts.arabic : AppFonts.english,

      scaffoldBackgroundColor: AppColors.primaryBackground,

      primaryColor: AppColors.primary,

      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        background: AppColors.primaryBackground,
      ),

      textTheme: TextTheme(
        headlineLarge: AppTextStyles.heading1,

        bodyLarge: AppTextStyles.body16,

        bodyMedium: AppTextStyles.body14,

        bodySmall: AppTextStyles.caption12,
      ),
    );
  }
}
