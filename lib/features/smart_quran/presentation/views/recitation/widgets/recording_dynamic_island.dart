import 'dart:ui' show FontFeature;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/animations/ade_slide_switcher.dart';
import 'package:islami/core/shared/animations/audio_wave_bars.dart';
import 'package:islami/core/shared/animations/pulsing_dot.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecordingDynamicIsland extends StatelessWidget {
  final bool isRecording;
  final Duration? elapsed;

  const RecordingDynamicIsland({
    super.key,
    this.isRecording = false,
    this.elapsed,
  });

  String _format(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final rec = isRecording;
    final accent = rec ? AppColors.incorrectWord : AppColors.primary;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 450),
      curve: Curves.easeOutBack,
      padding: EdgeInsets.symmetric(
        horizontal: rec ? 16.w : 12.w,
        vertical: rec ? 8.h : 5.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.ayahCardGradientBottom,
        borderRadius: BorderRadius.circular(30.r),
        border: Border.all(
          color: AppColors.primary.withValues(alpha: rec ? 0.55 : 0.15),
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withValues(alpha: rec ? 0.22 : 0.08),
            blurRadius: rec ? 18.r : 8.r,
            spreadRadius: rec ? 1.r : 0,
          ),
        ],
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutBack,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PulsingDot(pulsing: rec, color: accent, size: 8.w),
            SizedBox(width: 8.w),
            FadeSlideSwitcher(
              child: Text(
                rec ? l10n.recording : l10n.recitationMode,
                key: ValueKey(rec),
                style: AppTextStyles.body10.copyWith(
                  color: rec ? AppColors.white : AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (rec) ...[
              SizedBox(width: 10.w),
              AudioWaveBars(active: rec, color: AppColors.primary),
              if (elapsed != null) ...[
                SizedBox(width: 10.w),
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
