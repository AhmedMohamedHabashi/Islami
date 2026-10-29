import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/cubits/locale_cubit.dart';
import 'package:islami/core/localization/cubits/locale_state.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class LanguageSwitch extends StatelessWidget {
  const LanguageSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, LocaleState>(
      builder: (context, state) {
        final isEnglish = state.locale.languageCode == 'en';

        return PopupMenuButton<String>(
          tooltip: 'Change language',
          offset: Offset(0, 40.h),
          color: AppColors.primaryBackground,
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          onSelected: (languageCode) {
            if (languageCode != state.locale.languageCode) {
              context.read<LocaleCubit>().changeLanguage();
            }
          },
          itemBuilder: (context) => [
            PopupMenuItem<String>(
              value: 'ar',
              child: Row(
                children: [
                  Icon(
                    Icons.language_outlined,
                    color: !isEnglish ? AppColors.primary : AppColors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'العربية',
                    style: AppTextStyles.body14.copyWith(
                      color: !isEnglish ? AppColors.primary : AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  if (!isEnglish)
                    Icon(Icons.check, color: AppColors.primary, size: 18.sp),
                ],
              ),
            ),
            PopupMenuItem<String>(
              value: 'en',
              child: Row(
                children: [
                  Icon(
                    Icons.language_outlined,
                    color: isEnglish ? AppColors.primary : AppColors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'English',
                    style: AppTextStyles.body14.copyWith(
                      color: isEnglish ? AppColors.primary : AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  if (isEnglish)
                    Icon(Icons.check, color: AppColors.primary, size: 18.sp),
                ],
              ),
            ),
          ],
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language, color: AppColors.primary, size: 23.sp),
                SizedBox(width: 5.w),
                Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: AppColors.primary,
                  size: 20.sp,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
