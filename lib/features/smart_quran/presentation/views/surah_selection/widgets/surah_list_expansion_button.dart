import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class SurahListExpansionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final bool showLess;

  const SurahListExpansionButton({
    super.key,
    required this.onPressed,
    this.showLess = false,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return TextButton.icon(
      onPressed: onPressed,
      icon: Icon(
        showLess
            ? Icons.keyboard_arrow_up_rounded
            : Icons.keyboard_arrow_down_rounded,
      ),
      label: Text(showLess ? l10n.showLess : l10n.showMore),
      style: TextButton.styleFrom(
        foregroundColor: showLess
            ? AppColors.primary.withValues(alpha: 0.8)
            : AppColors.primary,
        textStyle: TextStyle(
          fontSize: showLess ? 13.sp : 14.sp,
          fontWeight: FontWeight.w600,
        ),
        padding: EdgeInsets.symmetric(vertical: showLess ? 8.h : 12.h),
      ),
    );
  }
}
