import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/constants/app_assets.dart';

class RadioCardDecoration extends StatelessWidget {
  const RadioCardDecoration({super.key, required this.showWaveform});

  final bool showWaveform;

  @override
  Widget build(BuildContext context) {
    if (showWaveform) {
      return IgnorePointer(
        child: Stack(
          children: [
            Positioned(
              left: -15.w,
              right: -15.w,
              bottom: -25.h,
              child: Image.asset(
                AppAssets.radioMask2,
                height: 80.h,
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
      );
    }

    return IgnorePointer(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          AppAssets.radioMask,
          width: double.infinity,
          height: 80.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
