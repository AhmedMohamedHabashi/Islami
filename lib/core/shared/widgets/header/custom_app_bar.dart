import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subtitle,
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
          // Title and subtitle in the center.
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 52.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.heading2.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.subtitleStyle.copyWith(
                    color: AppColors.white.withOpacity(0.6),
                    height: 1.0,
                  ),
                ),
              ],
            ),
          ),

          // Help button on the left.
          Align(
            alignment: Alignment.centerLeft,
            child: _HeaderActionButton(
              icon: Icons.help_outline_rounded,
              onTap: onHelp,
            ),
          ),

          // Back button on the right.
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
