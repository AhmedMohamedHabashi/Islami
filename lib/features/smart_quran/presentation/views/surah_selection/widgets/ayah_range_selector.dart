import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'ayah_counter.dart';
import 'recitation_mode_selector.dart';

class AyahRangeSelector extends StatelessWidget {
  final int startAyah;
  final int endAyah;
  final String selectedMode;

  final ValueChanged<int> onStartAyahChanged;
  final ValueChanged<int> onEndAyahChanged;
  final ValueChanged<String> onModeChanged;

  const AyahRangeSelector({
    super.key,
    required this.startAyah,
    required this.endAyah,
    required this.selectedMode,
    required this.onStartAyahChanged,
    required this.onEndAyahChanged,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.black.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: AppColors.white.withValues(alpha: 0.17)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'تحديد نطاق الحفظ (اختياري)',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: AyahCounter(
                  title: 'من الآية',
                  value: startAyah,
                  onChanged: onStartAyahChanged,
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: AyahCounter(
                  title: 'إلى الآية',
                  value: endAyah,
                  onChanged: onEndAyahChanged,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          RecitationModeSelector(
            selectedMode: selectedMode,
            onModeChanged: onModeChanged,
          ),
        ],
      ),
    );
  }
}
