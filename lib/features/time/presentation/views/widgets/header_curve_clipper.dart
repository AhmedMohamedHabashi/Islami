import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    double w = size.width;
    double h = size.height;

    double domeWidth = 190.w;
    double domeHeight = 65.h;
    double startX = (w - domeWidth) / 2;
    double endX = startX + domeWidth;

    path.moveTo(0, h);
    path.lineTo(w, h);
    path.lineTo(w, domeHeight + 15.h);
    path.quadraticBezierTo(w, domeHeight, w - 25.r, domeHeight);
    path.lineTo(endX + 30.w, domeHeight);
    path.quadraticBezierTo(
      endX + 5.w,
      domeHeight,
      endX - 5.w,
      domeHeight - 15.h,
    );
    path.quadraticBezierTo(endX - 25.r, 0, endX - 45.w, 0);
    path.lineTo(startX + 45.w, 0);
    path.quadraticBezierTo(startX + 25.r, 0, startX + 5.w, domeHeight - 15.h);
    path.quadraticBezierTo(startX - 5.w, domeHeight, startX - 30.w, domeHeight);
    path.lineTo(25.r, domeHeight);
    path.quadraticBezierTo(0, domeHeight, 0, domeHeight + 15.h);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
