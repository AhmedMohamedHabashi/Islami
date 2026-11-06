import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecitationSurahHeader extends StatelessWidget {
  final String surahName;
  final String ayahInfo;
  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  const RecitationSurahHeader({
    super.key,
    required this.surahName,
    required this.ayahInfo,
    this.onBack,
    this.onHelp,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // اسم السورة ومعلومات الآيات في المنتصف.
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                surahName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: AppTextStyles.heading2.copyWith(color: AppColors.white),
              ),
              SizedBox(height: 2.h),
              Flexible(
                child: Text(
                  ayahInfo,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body14.copyWith(
                    color: AppColors.primary,
                    height: 1.0.h,
                  ),
                ),
              ),
            ],
          ),

          Align(
            alignment: Alignment.centerLeft,
            child: _HeaderActionButton(
              icon: Icons.help_outline_rounded,
              onTap: onHelp,
            ),
          ),

          Align(
            alignment: Alignment.centerRight,
            child: _HeaderActionButton(
              icon: Icons.arrow_forward_ios_rounded,
              onTap: onBack ?? () => Navigator.maybePop(context),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _HeaderActionButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.ayahCardGradientBottom,
      borderRadius: BorderRadius.circular(14.r),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14.r),
        child: SizedBox(
          width: 44.w,
          height: 44.w,
          child: Icon(icon, color: AppColors.primary, size: 21.sp),
        ),
      ),
    );
  }
}
