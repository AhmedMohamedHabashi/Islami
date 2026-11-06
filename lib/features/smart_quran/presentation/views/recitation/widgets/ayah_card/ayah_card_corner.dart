import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class AyahCardCorner extends StatelessWidget {
  final int quarterTurns;

  const AyahCardCorner({super.key, required this.quarterTurns});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: Container(
        width: 14.w,
        height: 14.w,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.primary, width: 2.w),
            left: BorderSide(color: AppColors.primary, width: 2.w),
          ),
        ),
      ),
    );
  }
}
