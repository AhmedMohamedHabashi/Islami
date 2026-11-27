import 'package:flutter/material.dart';
import 'package:islami/config/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/animations/ade_slide_switcher.dart';
import 'package:islami/core/shared/animations/audio_wave_bars.dart';
import 'package:islami/core/shared/animations/pulsing_dot.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class RecordingDynamicIsland extends StatelessWidget {
  final bool isRecording;
  final Duration? elapsed;

  const RecordingDynamicIsland({
    super.key,
    this.isRecording = false,
    this.elapsed,
  });

  String _format(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final accentColor = isRecording
        ? AppColors.incorrectWord
        : AppColors.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutBack,
      padding: EdgeInsets.symmetric(
        horizontal: isRecording ? AppSizes.size16W : AppSizes.size12W,
        vertical: isRecording ? AppSizes.size8H : AppSizes.size5H,
      ),
      decoration: BoxDecoration(
        color: AppColors.ayahCardGradientBottom,
        borderRadius: BorderRadius.circular(AppSizes.radius30),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: isRecording ? 0.55 : 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: isRecording ? 0.22 : 0.08),
            blurRadius: isRecording ? AppSizes.size18W : AppSizes.size8W,
            spreadRadius: isRecording ? AppSizes.size1W : 0,
          ),
        ],
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutBack,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PulsingDot(
              pulsing: isRecording,
              color: accentColor,
              size: AppSizes.size8W,
            ),
            SizedBox(width: AppSizes.size8W),
            FadeSlideSwitcher(
              child: Text(
                isRecording ? l10n.recording : l10n.recitationMode,
                key: ValueKey(isRecording),
                style: AppTextStyles.body10.copyWith(
                  color: isRecording ? AppColors.white : AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (isRecording) ...[
              SizedBox(width: AppSizes.size10W),
              AudioWaveBars(active: true, color: AppColors.primary),
              if (elapsed != null) ...[
                SizedBox(width: AppSizes.size10W),
                Text(
                  _format(elapsed!),
                  style: AppTextStyles.body10.copyWith(
                    color: AppColors.white.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w500,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
