import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class PetalsFab extends StatelessWidget {
  static const Color _background = Color(0xFF2B2825);

  const PetalsFab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64.w,
      height: 64.w,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _background,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Center(
        child: SizedBox(
          width: 40.w,
          height: 40.w,
          child: CustomPaint(painter: _PetalsPainter()),
        ),
      ),
    );
  }
}

class _PetalsPainter extends CustomPainter {
  static const int _petals = 8;
  static const Color _deepGold = Color(0xFFB8864A);

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.width * 0.32;
    final petal = Rect.fromCenter(
      center: Offset.zero,
      width: size.width * 0.2,
      height: size.height * 0.3,
    );

    for (var i = 0; i < _petals; i++) {
      final paint = Paint()
        ..color = Color.lerp(AppColors.primary, _deepGold, i / (_petals - 1))!;

      canvas
        ..save()
        ..translate(center.dx, center.dy)
        ..rotate(2 * math.pi * i / _petals)
        ..translate(0, -radius)
        ..rotate(math.pi / 8)
        ..drawOval(petal, paint)
        ..restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
