import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class RecitationStatusIndicator extends StatelessWidget {
  final String statusText;
  final bool isLoading;
  final bool isError;
  final bool isRecording;

  const RecitationStatusIndicator({
    super.key,
    required this.statusText,
    this.isLoading = false,
    this.isError = false,
    this.isRecording = false,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = isError
        ? AppColors.incorrectWord
        : isRecording
        ? AppColors.primary
        : AppColors.primary.withValues(alpha: 0.75);

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 250),
      child: Row(
        key: ValueKey('$statusText-$isLoading-$isError-$isRecording'),
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading)
            SizedBox(
              width: AppSizes.size16W,
              height: AppSizes.size16H,
              child: CircularProgressIndicator(
                strokeWidth: AppSizes.size2W,
                backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                color: AppColors.primary,
              ),
            )
          else
            Icon(
              isError
                  ? Icons.error_outline_rounded
                  : isRecording
                  ? Icons.mic_rounded
                  : Icons.info_outline_rounded,
              size: AppSizes.icon18,
              color: statusColor,
            ),
          SizedBox(width: AppSizes.size8W),
          Flexible(
            child: Text(
              statusText,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(color: statusColor),
            ),
          ),
        ],
      ),
    );
  }
}
