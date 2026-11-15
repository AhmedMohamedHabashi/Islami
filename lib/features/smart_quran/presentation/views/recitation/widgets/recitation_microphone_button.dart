import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/shared/animations/press_scale.dart';
import 'package:islami/core/shared/animations/pulse_rings.dart';
import 'package:islami/core/themes/colors/app_colors.dart';

class RecitationMicrophoneButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isRecording;
  final bool isEnabled;

  const RecitationMicrophoneButton({
    super.key,
    required this.onTap,
    this.isRecording = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = isRecording ? AppColors.incorrectWord : AppColors.primary;
    final inner = 68.w;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: isRecording ? 'إيقاف التسجيل' : 'بدء التسميع',
      child: SizedBox(
        width: 88.w,
        height: 88.w,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            // الهالة + الجلو
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.12),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: isRecording ? 0.28 : 0.15),
                    blurRadius: isRecording ? 30.r : 22.r,
                    spreadRadius: isRecording ? 6.r : 4.r,
                  ),
                ],
              ),
            ),

            PulseRings(active: isRecording, color: color, size: inner),

            PressScale(
              onTap: isEnabled ? onTap : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                width: inner,
                height: inner,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    isRecording ? 22.r : inner / 2,
                  ),
                  color: isEnabled ? null : AppColors.progressBackground,
                  gradient: isEnabled
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.lerp(color, Colors.white, 0.18)!,
                            color,
                          ],
                        )
                      : null,
                  boxShadow: isEnabled
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.35),
                            blurRadius: 12.r,
                            offset: Offset(0, 4.h),
                          ),
                        ]
                      : null,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, anim) => RotationTransition(
                    turns: Tween(begin: 0.85, end: 1.0).animate(anim),
                    child: ScaleTransition(
                      scale: anim,
                      child: FadeTransition(opacity: anim, child: child),
                    ),
                  ),
                  child: Icon(
                    isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                    key: ValueKey(isRecording),
                    color: AppColors.black.withValues(
                      alpha: isEnabled ? 1 : 0.35,
                    ),
                    size: 32.sp,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
