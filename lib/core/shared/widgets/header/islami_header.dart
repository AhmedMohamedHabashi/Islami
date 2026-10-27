import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_assets.dart';

class IslamiHeader extends StatelessWidget {
  final bool compact;
  final bool showMosque;

  const IslamiHeader({super.key}) : compact = false, showMosque = true;

  const IslamiHeader.compact({super.key, this.showMosque = false})
    : compact = true;

  @override
  Widget build(BuildContext context) {
    final headerHeight = compact ? 75.h : 195.h;
    final logoWidth = compact ? 115.w : 166.w;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, (compact ? -10.h : -25.h) * (1 - value)),
          child: Opacity(
            opacity: value,
            child: SizedBox(
              height: headerHeight,
              width: double.infinity,
              child: Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.hardEdge,
                children: [
                  if (showMosque && !compact)
                    Positioned(
                      top: 10.h,
                      child: Image.asset(
                        AppAssets.mosque,
                        height: 165.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  if (showMosque && compact)
                    Positioned(
                      top: 0,
                      child: Image.asset(
                        AppAssets.mosque,
                        height: 65.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  Positioned(
                    bottom: compact ? 5.h : 50.h,
                    child: Image.asset(
                      AppAssets.islami,
                      width: logoWidth,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
