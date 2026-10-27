import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final buttonColor = isRecording ? Colors.redAccent : AppColors.primary;

    return Semantics(
      button: true,
      enabled: isEnabled,
      label: isRecording ? 'إيقاف التسجيل' : 'بدء التسميع',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: 88.w,
        height: 88.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: buttonColor.withValues(alpha: 0.12),
          boxShadow: [
            BoxShadow(
              color: buttonColor.withValues(alpha: 0.15),
              blurRadius: 22.r,
              spreadRadius: 4.r,
            ),
          ],
        ),
        child: Center(
          child: Material(
            color: isEnabled ? buttonColor : AppColors.progressBackground,
            shape: const CircleBorder(),
            child: InkWell(
              onTap: isEnabled ? onTap : null,
              customBorder: const CircleBorder(),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 68.w,
                height: 68.w,
                alignment: Alignment.center,
                child: Icon(
                  isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                  color: isEnabled
                      ? AppColors.black
                      : AppColors.progressBackground,
                  size: 32.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
