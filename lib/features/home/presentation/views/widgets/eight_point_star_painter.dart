import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

/// نجمة ثمانية (رُبع الحزب) = مربعين متداخلين.
class EightPointStarPainter extends CustomPainter {
  EightPointStarPainter({required this.progress}) : super(repaint: progress);

  final Animation<double> progress;

  static const Color _deepGold = Color(0xFFB8864A);

  Path _square(Offset c, double r, double rotation) {
    final path = Path();
    for (var i = 0; i < 4; i++) {
      final a = rotation + i * math.pi / 2;
      final x = c.dx + r * math.cos(a);
      final y = c.dy + r * math.sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    return path..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final angle = 2 * math.pi * progress.value;
    final breathing = 1 + 0.05 * math.sin(angle * 4);
    final rect = Rect.fromCircle(center: center, radius: size.width / 2);

    final sweep = SweepGradient(
      colors: [AppColors.primary, _deepGold, AppColors.primary],
      transform: GradientRotation(angle * 2),
    ).createShader(rect);

    final outerR = size.width * 0.44 * breathing;

    final fill = Paint()
      ..shader = sweep
      ..style = PaintingStyle.fill
      ..color = Colors.white.withValues(alpha: 0.35);
    final stroke = Paint()
      ..shader = sweep
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = size.width * 0.035;

    final squareA = _square(center, outerR, angle);
    final squareB = _square(center, outerR, angle + math.pi / 4);

    canvas
      ..saveLayer(rect, Paint()..color = Colors.white.withValues(alpha: 0.4))
      ..drawPath(squareA, fill)
      ..drawPath(squareB, fill)
      ..restore()
      ..drawPath(squareA, stroke)
      ..drawPath(squareB, stroke);

    final innerR = size.width * 0.22;
    final innerA = _square(center, innerR, -angle * 1.5);
    final innerB = _square(center, innerR, -angle * 1.5 + math.pi / 4);
    final innerFill = Paint()
      ..color = AppColors.primaryBackground.withValues(alpha: 0.9);
    final innerStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeWidth = size.width * 0.022
      ..color = AppColors.primary.withValues(alpha: 0.9);

    canvas
      ..drawPath(innerA, innerFill)
      ..drawPath(innerB, innerFill)
      ..drawPath(innerA, innerStroke)
      ..drawPath(innerB, innerStroke);

    final dotRadius = size.width * 0.06 * breathing;
    canvas.drawCircle(
      center,
      dotRadius,
      Paint()
        ..shader = RadialGradient(
          colors: [Colors.white.withValues(alpha: 0.95), AppColors.primary],
        ).createShader(Rect.fromCircle(center: center, radius: dotRadius)),
    );
  }

  @override
  bool shouldRepaint(covariant EightPointStarPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
