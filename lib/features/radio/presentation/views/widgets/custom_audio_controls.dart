import 'package:flutter/material.dart';
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
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onMutePressed,
          tooltip: isMuted ? 'Unmute' : 'Mute',
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 32, height: 38),
          icon: Icon(
            isMuted ? Icons.volume_off : Icons.volume_up,
            size: 30,
            color: color,
          ),
        ),
        const SizedBox(width: 4),

        IconButton(
          onPressed: onPlayPressed,
          tooltip: isPlaying ? 'Pause' : 'Play',
          visualDensity: VisualDensity.compact,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints.tightFor(width: 38, height: 38),
          icon: Icon(
            isPlaying ? Icons.pause : Icons.play_arrow,
            size: 40,
            color: color,
          ),
        ),
      ],
    );
  }
}
