import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/app_sizes.dart';

class AyahCardCorner extends StatelessWidget {
  final int quarterTurns;

  const AyahCardCorner({super.key, required this.quarterTurns});

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: quarterTurns,
      child: Container(
        width: AppSizes.size14W,
        height: AppSizes.size14H,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.primary, width: AppSizes.size2W),
            left: BorderSide(color: AppColors.primary, width: AppSizes.size2W),
          ),
        ),
      ),
    );
  }
}
