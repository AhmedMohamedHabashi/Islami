import 'package:flutter/material.dart';
// import 'package:islami/core/constants/app_assets.dart';

class RadioHeader extends StatelessWidget {
  const RadioHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 124,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Positioned(
          //   top: 3,
          //   child: Opacity(
          //     opacity: 0.72,
          //     child: Image.asset(
          //       AppAssets.mosque,
          //       width: 248,
          //       height: 105,
          //       fit: BoxFit.contain,
          //     ),
          //   ),
          // ),
          // Positioned(
          //   bottom: 4,
          //   child: Image.asset(
          //     AppAssets.islami,
          //     width: 126,
          //     height: 36,
          //     fit: BoxFit.contain,
          //   ),
          // ),
        ],
      ),
    );
  }
}
