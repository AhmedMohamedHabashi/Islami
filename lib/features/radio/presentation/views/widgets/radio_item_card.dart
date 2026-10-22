import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/features/radio/presentation/views/widgets/custom_audio_controls.dart';
import 'package:islami/features/radio/presentation/views/widgets/radio_card_decoration.dart';

class RadioItemCard extends StatelessWidget {
  const RadioItemCard({
    super.key,
    required this.title,
    this.isPlaying = false,
    this.isMuted = false,
    this.showWaveform = false,
    this.onTap,
    this.onPlayPressed,
    this.onMutePressed,
  });

  final String title;
  final bool isPlaying;
  final bool isMuted;
  final bool showWaveform;
  final VoidCallback? onTap;
  final VoidCallback? onPlayPressed;
  final VoidCallback? onMutePressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primary,
      borderRadius: BorderRadius.circular(12.r),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 102.h,
          width: double.infinity,
          child: Stack(
            children: [
              Positioned.fill(
                child: RadioCardDecoration(showWaveform: showWaveform),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(12.w, 9.h, 12.w, 5.h),
                child: Column(
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: AppTextStyles.body20.copyWith(
                        color: AppColors.black,
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AudioControls(
                          isPlaying: isPlaying,
                          isMuted: isMuted,
                          onPlayPressed: onPlayPressed,
                          onMutePressed: onMutePressed,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
