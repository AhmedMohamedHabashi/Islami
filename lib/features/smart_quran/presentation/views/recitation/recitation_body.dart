import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/shared/widgets/header/custom_app_bar.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/current_ayah_card.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/live_recitation_header.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_controls.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_microphone_button.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/widgets/recitation_status_indicator.dart';

class RecitationBody extends StatelessWidget {
  const RecitationBody({super.key});

  static void _onMicrophoneTap() {
    // TODO: Connect to RecitationCubit later.
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(16.w, 40.h, 16.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CustomAppBar(title: 'سورة الكهف', subtitle: 'الآيات 1 - 10'),
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

          Center(child: RecitationMicrophoneButton(onTap: _onMicrophoneTap)),
          SizedBox(height: 15.h),

          RecitationControls(
            onListen: () {
              // TODO: Connect Quran audio playback later.
            },
            onFinish: () {
              context.push(RouteNames.recitationReportView);
            },
          ),
        ],
      ),
    );
  }
}
