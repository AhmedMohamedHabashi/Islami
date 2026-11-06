import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/current_ayah_card.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/live_recitation_header.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_controls.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_microphone_button.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_status_indicator.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_surah_header.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recording_dynamic_island.dart';

class RecitationView extends StatelessWidget {
  const RecitationView({super.key});

  static void _onMicrophoneTap() {
    // TODO: Connect to RecitationCubit later.
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 58.h, 16.w, 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const RecitationSurahHeader(
                    surahName: 'سورة الكهف',
                    ayahInfo: 'الآيات 1 - 10',
                  ),
                  SizedBox(height: 15.h),

                  const LiveRecitationHeader(duration: '00:00'),
                  SizedBox(height: 15.h),

                  const CurrentAyahCard(
                    surahName: 'سورة الكهف',
                    ayahNumber: 1,
                    ayahText:
                        'الْحَمْدُ لِلَّهِ الَّذِي أَنزَلَ عَلَىٰ عَبْدِهِ الْكِتَابَ',
                    highlightedWord: 'أَنزَلَ',
                  ),
                  SizedBox(height: 15.h),

                  const RecitationStatusIndicator(
                    statusText: 'استعد للتسميع عند الضغط على الميكروفون',
                  ),
                  SizedBox(height: 15.h),

                  Center(
                    child: RecitationMicrophoneButton(onTap: _onMicrophoneTap),
                  ),
                  SizedBox(height: 15.h),

                  RecitationControls(
                    onListen: () {
                      // TODO: Connect Quran audio playback later.
                    },
                    onFinish: () {
                      // TODO: Open the recitation report later.
                    },
                  ),
                ],
              ),
            ),
          ),

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
