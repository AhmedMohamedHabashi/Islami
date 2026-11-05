import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

enum ReportStatBoxStyle { normal, highlighted, dashed }

class ReportStatBox extends StatelessWidget {
  final ReportStatBoxStyle style;
  final String title;
  final String value;
  final String description;

  const ReportStatBox({
    super.key,
    required this.style,
    required this.title,
    required this.value,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final isHighlighted = style == ReportStatBoxStyle.highlighted;
    final isDashed = style == ReportStatBoxStyle.dashed;

    final titleColor = isHighlighted
        ? AppColors.white
        : AppColors.white.withValues(alpha: 0.7);

    final valueColor = isHighlighted ? AppColors.white : AppColors.primary;

    final descriptionColor = isHighlighted
        ? AppColors.primary
        : AppColors.white.withValues(alpha: 0.55);

    final content = Container(
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: isDashed
            ? AppColors.white.withValues(alpha: 0.025)
            : AppColors.progressBackground,
        borderRadius: BorderRadius.circular(14.r),
        border: isDashed
            ? null
            : Border.all(
                color: isHighlighted
                    ? AppColors.primary.withValues(alpha: 0.9)
                    : AppColors.white.withValues(alpha: 0.15),
                width: isHighlighted ? 1.4.w : 1.1.w,
              ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body10.copyWith(
              color: titleColor,

              fontWeight: isHighlighted ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          SizedBox(height: 5.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: AppTextStyles.body14.copyWith(
                color: valueColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            description,
            maxLines: 1,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.body10.copyWith(color: descriptionColor),
          ),
        ],
      ),
    );

    if (isDashed) {
      return CustomPaint(
        foregroundPainter: _DashedBorderPainter(
          color: AppColors.primary.withValues(alpha: 0.65),
          radius: 14.r,
        ),
        child: content,
      );
    }

    return content;
  }
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dash;
  final double gap;

  const _DashedBorderPainter({
    required this.color,
    required this.radius,
    this.dash = 5,
    this.gap = 3.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2.w
      ..color = color;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;

      while (distance < metric.length) {
        final end = math.min(distance + dash, metric.length);

        canvas.drawPath(metric.extractPath(distance, end), paint);

        distance += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.radius != radius ||
        oldDelegate.dash != dash ||
        oldDelegate.gap != gap;
  }
}
