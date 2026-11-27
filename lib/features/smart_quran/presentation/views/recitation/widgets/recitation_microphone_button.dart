import 'package:flutter/material.dart';
import 'package:islami/core/shared/animations/press_scale.dart';
import 'package:islami/core/shared/animations/pulse_rings.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/app_sizes.dart';

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
    final inner = AppSizes.size68W;
    final outer = AppSizes.size88W;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: isRecording ? 'إيقاف التسجيل' : 'بدء التسميع',
      onTap: isEnabled ? onTap : null,
      child: SizedBox(
        width: outer,
        height: AppSizes.size88H,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: outer,
              height: outer,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withValues(alpha: 0.12),
                boxShadow: [
                  BoxShadow(
                    color: color.withValues(alpha: isRecording ? 0.28 : 0.15),
                    blurRadius: isRecording
                        ? AppSizes.size30W
                        : AppSizes.size22W,
                    spreadRadius: isRecording
                        ? AppSizes.size6W
                        : AppSizes.size4W,
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
                    isRecording ? AppSizes.radius22 : inner / 2,
                  ),
                  color: isEnabled ? null : AppColors.progressBackground,
                  gradient: isEnabled
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color.lerp(color, AppColors.white, 0.18)!,
                            color,
                          ],
                        )
                      : null,
                  boxShadow: isEnabled
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.35),
                            blurRadius: AppSizes.size12H,
                            offset: Offset(0, AppSizes.size4H),
                          ),
                        ]
                      : null,
                ),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return RotationTransition(
                      turns: Tween(begin: 0.85, end: 1.0).animate(animation),
                      child: ScaleTransition(
                        scale: animation,
                        child: FadeTransition(opacity: animation, child: child),
                      ),
                    );
                  },
                  child: Icon(
                    isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                    key: ValueKey(isRecording),
                    color: AppColors.black.withValues(
                      alpha: isEnabled ? 1 : 0.35,
                    ),
                    size: AppSizes.icon32,
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
