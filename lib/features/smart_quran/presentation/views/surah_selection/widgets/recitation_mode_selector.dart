import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RecitationModeSelector extends StatelessWidget {
  final String selectedMode;
  final ValueChanged<String> onModeChanged;

  const RecitationModeSelector({
    super.key,
    required this.selectedMode,
    required this.onModeChanged,
  });

  static const String repetitionMode = 'القراءة والترديد';
  static const String errorMode = 'التسميع بالأخطاء الاصطناعية';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'نمط التسميع المفضل',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: AppColors.white.withValues(alpha: 0.65),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(child: _buildModeButton(repetitionMode)),
            SizedBox(width: 8.w),
            Expanded(child: _buildModeButton(errorMode)),
          ],
        ),
      ],
    );
  }

  Widget _buildModeButton(String text) {
    final bool selected = selectedMode == text;

    return InkWell(
      onTap: () => onModeChanged(text),
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 11.h),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: selected
                ? AppColors.primary
                : AppColors.white.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: AppTextStyles.body12.copyWith(
            color: selected ? AppColors.black : AppColors.white,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
