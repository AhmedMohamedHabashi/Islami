import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation_report/widgets/recitation_audio_card.dart';
import '../../../../domain/entities/recitation_report.dart';
import '../../../cubit/recitation_report/recitation_report_cubit.dart';

class RecitationAlertSection extends StatelessWidget {
  final RecitationWord word;
  final RecitationWordAlert alert;
  final RecitationAudioTarget? playingTarget;
  final ValueChanged<RecitationAudioTarget> onPlayTap;

  const RecitationAlertSection({
    super.key,
    required this.word,
    required this.alert,
    required this.playingTarget,
    required this.onPlayTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 8.w,
                height: 8.h,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  l10n.recitationPronunciationAlert(word.text),
                  style: AppTextStyles.body12.copyWith(color: AppColors.white),
                ),
              ),
              Text(
                l10n.recitationAyahNumber(alert.ayahNumber),
                style: AppTextStyles.body12.copyWith(
                  color: AppColors.white.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: RecitationAudioCard(
                    title: l10n.recitationCorrectFace(alert.ruleName),
                    text: alert.correctText,
                    hint: alert.correctHint == null
                        ? null
                        : '(${alert.correctHint})',
                    isHighlighted: true,
                    isPlaying: playingTarget == RecitationAudioTarget.correct,
                    onPlayTap: () {
                      onPlayTap(RecitationAudioTarget.correct);
                    },
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: RecitationAudioCard(
                    title: l10n.recitationRecordedTitle,
                    text: alert.recordedText,
                    isPlaying: playingTarget == RecitationAudioTarget.recorded,
                    onPlayTap: () {
                      onPlayTap(RecitationAudioTarget.recorded);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
