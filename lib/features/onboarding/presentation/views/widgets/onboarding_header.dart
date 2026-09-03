import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_assets.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeOut,

      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, -25.h * (1 - value)),
          child: Opacity(
            opacity: value,

            child: SizedBox(
              height: 205.h,
              child: Stack(
                alignment: Alignment.topCenter,

                children: [
                  Positioned(
                    top: 10.h,
                    child: Image.asset(
                      AppAssets.mosque,
                      height: 190.h,
                      fit: BoxFit.contain,
                    ),
                  ),

                  Positioned(
                    bottom: 50.h,
                    child: Image.asset(
                      AppAssets.islami,
                      width: 166.w,
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
