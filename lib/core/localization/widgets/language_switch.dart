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

        return GestureDetector(
          onTap: () {
            context.read<LocaleCubit>().changeLanguage();
          },
          child: Container(
            width: 110.w,
            height: 38.h,
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Stack(
              children: [
                AnimatedAlign(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeInOut,
                  alignment: isEnglish
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    width: 50.w,
                    height: 30.h,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerLeft,
                  child: _label('العربية', !isEnglish),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: _label('English', isEnglish),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _label(String text, bool active) {
    return SizedBox(
      width: 50.w,
      child: Center(
        child: Text(
          text,
          style: AppTextStyles.caption12.copyWith(
            color: active ? AppColors.white : AppColors.primary,
          ),
        ),
      ),
    );
  }
}
