import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class SurahNumberBadge extends StatelessWidget {
  final int number;

  const SurahNumberBadge({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 52.w,
      height: 52.w,
      child: CustomPaint(
        painter: _StarPainter(),
        child: Center(
          child: Text(
            '$number',
            style: AppTextStyles.body18.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

class _StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final outer = size.width / 2 - 2;
    final inner = outer * 0.78;
    const points = 8;

    final path = Path();
    for (var i = 0; i < points * 2; i++) {
      final radius = i.isEven ? outer : inner;
      final angle = (math.pi / points) * i - math.pi / 2;
      final point = Offset(
        center.dx + radius * math.cos(angle),
        center.dy + radius * math.sin(angle),
      );
      i == 0 ? path.moveTo(point.dx, point.dy) : path.lineTo(point.dx, point.dy);
    }
    path.close();

    canvas.drawPath(path, Paint()..color = AppColors.primaryBackground);
    canvas.drawPath(
      path,
      Paint()
        ..color = AppColors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..strokeJoin = StrokeJoin.round,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
