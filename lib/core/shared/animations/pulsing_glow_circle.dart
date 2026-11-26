import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/app_sizes.dart';

/// دايرة بخلفية متدرجة، حدودها وتوهجها بينبضوا مع الـ animation.
class PulsingGlowCircle extends StatelessWidget {
  const PulsingGlowCircle({
    super.key,
    required this.animation,
    required this.size,
    required this.child,
    this.pulsesPerLoop = 4, // لازم رقم صحيح عشان الحلقة تفضل سلسة
  });

  final Animation<double> animation;
  final double size;
  final int pulsesPerLoop;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      child: child,
      builder: (context, child) {
        final pulse =
            0.5 + 0.5 * math.sin(animation.value * 2 * math.pi * pulsesPerLoop);
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Color.lerp(
                  AppColors.primaryBackground,
                  AppColors.primary,
                  0.16,
                )!,
                AppColors.primaryBackground,
              ],
            ),
            border: Border.all(
              color: AppColors.primary.withValues(alpha: 0.3 + 0.2 * pulse),
              width: AppSizes.size1_5w,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.12 + 0.2 * pulse),
                blurRadius: AppSizes.size14W + AppSizes.size8W * pulse,
                spreadRadius: AppSizes.size1W + AppSizes.size2W * pulse,
              ),
              BoxShadow(
                color: AppColors.black.withValues(alpha: 0.4),
                blurRadius: AppSizes.size12W,
                offset: Offset(0, AppSizes.size4H),
              ),
            ],
          ),
          child: child,
        );
      },
    );
  }
}
