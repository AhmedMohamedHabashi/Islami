import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/core/shared/widgets/header/islami_header.dart';
import 'package:islami/features/time/presentation/views/widgets/time_view_body.dart';

class TimeView extends StatefulWidget {
  const TimeView({super.key});

  @override
  State<TimeView> createState() => _TimeViewState();
}

class _TimeViewState extends State<TimeView> {
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
                const IslamiHeader(small: true),
                const Expanded(child: TimeViewBody()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
