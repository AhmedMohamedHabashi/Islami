import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/app_sizes.dart';

class ReportDiamond extends StatelessWidget {
  const ReportDiamond({super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: math.pi / 4,
      child: Container(
        width: AppSizes.size7W,
        height: AppSizes.size7H,
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
