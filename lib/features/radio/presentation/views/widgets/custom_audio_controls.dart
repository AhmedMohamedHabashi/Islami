import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class AudioControls extends StatelessWidget {
  const AudioControls({
    super.key,
    required this.isPlaying,
    required this.isMuted,
    this.onPlayPressed,
    this.onMutePressed,
    this.color = AppColors.black,
  });

  final bool isPlaying;
  final bool isMuted;
  final VoidCallback? onPlayPressed;
  final VoidCallback? onMutePressed;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = [
      l10n.time,
      l10n.radio,
      l10n.tasbih,
      l10n.hadith,
      l10n.quran,
    ];
    return Padding(
      padding: EdgeInsets.only(left: 40.0.w),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onMutePressed,
            tooltip: isMuted ? 'Unmute' : 'Mute',
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 48.w, height: 48.h),
            icon: Icon(
              isMuted ? Icons.volume_off : Icons.volume_up,
              size: 40.h,
              color: color,
            ),
          ),
          SizedBox(width: 2.w),
          IconButton(
            onPressed: onPlayPressed,
            tooltip: isPlaying ? 'Pause' : 'Play',
            padding: EdgeInsets.zero,
            constraints: BoxConstraints.tightFor(width: 56.w, height: 56.h),
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              size: 50.h,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
