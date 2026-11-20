import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'ayah_number_picker_dialog.dart';

class AyahCounterValue extends StatelessWidget {
  final String title;
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const AyahCounterValue({
    super.key,
    required this.title,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  Future<void> _showPicker(BuildContext context) async {
    final result = await showDialog<int>(
      context: context,
      builder: (_) => AyahNumberPickerDialog(
        title: title,
        value: value,
        minValue: minValue,
        maxValue: maxValue,
      ),
    );

    if (result != null) {
      onChanged(result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showPicker(context),
      borderRadius: BorderRadius.circular(6.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '$value',
              style: AppTextStyles.body14.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 3.w),
            Icon(
              Icons.edit,
              size: 11.sp,
              color: AppColors.primary.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }
}
