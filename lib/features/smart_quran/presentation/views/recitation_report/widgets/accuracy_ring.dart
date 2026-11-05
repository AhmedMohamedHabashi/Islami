import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class AccuracyRing extends StatelessWidget {
  final double percent;
  final String label;

  const AccuracyRing({super.key, required this.percent, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 82.w,
      height: 82.w,
      child: CustomPaint(
        painter: _RingPainter(percent: percent, strokeWidth: 7.w),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: AppTextStyles.body18.copyWith(
                    color: AppColors.primary,
                    height: 1.h,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'درجة الإتقان',
                textAlign: TextAlign.center,
                style: AppTextStyles.body10.copyWith(
                  color: AppColors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent;
  final double strokeWidth;

  const _RingPainter({required this.percent, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final rect =
        Offset(strokeWidth / 2, strokeWidth / 2) &
        Size(size.width - strokeWidth, size.height - strokeWidth);

    final trackPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = AppColors.primary.withValues(alpha: 0.12);

    canvas.drawArc(rect, 0, math.pi * 2, false, trackPaint);

    final progressPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..color = AppColors.primary;

    canvas.drawArc(
      rect,
      -math.pi / 2,
      math.pi * 2 * percent.clamp(0.0, 1.0),
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.percent != percent ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
