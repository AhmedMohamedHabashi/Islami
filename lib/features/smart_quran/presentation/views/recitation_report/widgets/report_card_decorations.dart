import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class ReportDiamond extends StatelessWidget {
  const ReportDiamond({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: 7.w,
        height: 7.w,
        decoration: BoxDecoration(
          color: AppColors.primaryBackground,
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.7),
            width: 1,
          ),
        ),
      ),
    );
  }
}
