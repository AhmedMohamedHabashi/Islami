import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_assets.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        height: 250,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
             AppAssets.mosque,
              height: 250,
              fit: BoxFit.contain,
            ),
            Image.asset(
             AppAssets.islami,

              height: 70,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}