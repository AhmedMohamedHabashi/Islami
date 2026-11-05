import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/recitation_body.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recording_dynamic_island.dart';

class RecitationView extends StatelessWidget {
  const RecitationView({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          const SafeArea(child: RecitationBody()),

          Positioned(
            top: topInset + 2.h,
            left: 0,
            right: 0,
            child: const Center(child: RecordingDynamicIsland()),
          ),
        ],
      ),
    );
  }
}
