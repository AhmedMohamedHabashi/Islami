import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/shared/widgets/header/islami_header.dart';
import 'package:islami/features/time/presentation/views/widgets/time_view_body.dart';

class TimeView extends StatelessWidget {
  const TimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(AppAssets.timeBackground, fit: BoxFit.cover),
          ),

          SafeArea(
            child: Column(
              children: [
                const IslamiHeader(),

                const Expanded(child: TimeViewBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
