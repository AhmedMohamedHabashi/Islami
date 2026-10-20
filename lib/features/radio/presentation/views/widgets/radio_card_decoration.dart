import 'package:flutter/material.dart';
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
              left: -15,
              right: -15,
              bottom: -25,
              child: Image.asset(
                AppAssets.radioMask2,
                height: 70,
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
          height: 70,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
