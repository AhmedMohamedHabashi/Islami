import 'package:flutter/material.dart';
import 'package:islami/core/shared/widgets/app_bar/custom_app_bar.dart';
import 'package:islami/core/utils/app_sizes.dart';
import 'package:islami/features/smart_quran/domain/entities/ayah.dart';
import 'widgets/current_ayah_card.dart';
import 'widgets/live_recitation_header.dart';
import 'widgets/recitation_controls.dart';
import 'widgets/recitation_microphone_button.dart';
import 'widgets/recitation_status_indicator.dart';

class RecitationBody extends StatelessWidget {
  final VoidCallback onMicrophoneTap;
  final VoidCallback onListen;
  final VoidCallback onFinish;

  final VoidCallback? onBack;
  final VoidCallback? onHelp;

  final String surahName;
  final String ayahInfo;
  final String duration;
  final String statusText;

  final List<Ayah> ayahs;

  final String? highlightedWord;
  final bool showBasmala;

  final bool isRecording;
  final bool isLoading;
  final bool isEnabled;

  const RecitationBody({
    super.key,
    required this.onMicrophoneTap,
    required this.onListen,
    required this.onFinish,
    required this.ayahs,
    this.onBack,
    this.onHelp,
    this.surahName = 'سورة الكهف',
    this.ayahInfo = 'الآيات 1 - 10',
    this.duration = '00:00',
    this.highlightedWord,
    this.statusText = 'استعد للتسميع عند الضغط على الميكروفون',
    this.isRecording = false,
    this.isLoading = false,
    this.isEnabled = true,
    this.showBasmala = true,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppSizes.size16W,
        AppSizes.size46H,
        AppSizes.size16W,
        AppSizes.size16H,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            title: surahName,
            subtitle: ayahInfo,
            onBack: onBack,
            onHelp: onHelp,
          ),

          SizedBox(height: AppSizes.size14H),

          LiveRecitationHeader(duration: duration, isRecording: isRecording),

          SizedBox(height: AppSizes.size14H),

          CurrentAyahCard(
            surahName: surahName,
            ayahs: ayahs,
            highlightedWord: highlightedWord,
            showBasmala: showBasmala,
          ),
          SizedBox(height: AppSizes.size14H),

          RecitationStatusIndicator(
            statusText: statusText,
            isLoading: isLoading,
          ),

          SizedBox(height: AppSizes.size14H),

          Center(
            child: RecitationMicrophoneButton(
              onTap: onMicrophoneTap,
              isRecording: isRecording,
              isEnabled: isEnabled,
            ),
          ),

          SizedBox(height: AppSizes.size14H),

          RecitationControls(
            onListen: onListen,
            onFinish: onFinish,
            isEnabled: isEnabled,
          ),
        ],
      ),
    );
  }
}
