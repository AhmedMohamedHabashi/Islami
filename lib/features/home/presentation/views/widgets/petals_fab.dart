import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/shared/animations/elastic_entrance.dart';
import 'package:islami/core/shared/animations/looping_animation.dart';
import 'package:islami/core/shared/animations/press_scale.dart';
import 'package:islami/core/shared/animations/pulsing_glow_circle.dart';
import 'package:islami/core/utils/app_sizes.dart';
import 'eight_point_star_painter.dart';

class PetalsFab extends StatelessWidget {
  const PetalsFab({super.key});

  @override
  Widget build(BuildContext context) {
    return ElasticEntrance(
      child: PressScale(
        haptic: true,
        onTap: () => context.push(RouteNames.surahSelectionView),
        child: RepaintBoundary(
          child: LoopingAnimation(
            duration: const Duration(seconds: 16),
            builder: (context, loop) => PulsingGlowCircle(
              animation: loop,
              size: AppSizes.size64W,
              child: Center(
                child: SizedBox(
                  width: AppSizes.size44W,
                  height: AppSizes.size44W,
                  child: CustomPaint(
                    painter: EightPointStarPainter(progress: loop),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
