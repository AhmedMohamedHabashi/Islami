import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:islami/core/themes/colors/app_colors.dart';

class CustomInfoDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final VoidCallback? onPressed;

  const CustomInfoDialog({
    super.key,
    required this.title,
    required this.message,
    this.buttonText = 'حسنًا',
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.ayahCardGradientTop,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        title,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 20.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        message,
        style: TextStyle(color: AppColors.white, fontSize: 15.sp, height: 1.6),
      ),
      actions: [
        TextButton(
          onPressed: onPressed ?? () => Navigator.of(context).pop(),
          child: Text(
            buttonText,
            style: const TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
