import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'ayah_counter_button.dart';
import 'ayah_counter_value.dart';

class AyahCounter extends StatelessWidget {
  final String title;
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const AyahCounter({
    super.key,
    required this.title,
    required this.value,
    this.minValue = 1,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: AppColors.white.withValues(alpha: 0.65),
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AyahCounterButton(
                icon: Icons.remove,
                onTap: () {
                  if (value > minValue) {
                    onChanged(value - 1);
                  }
                },
              ),
              AyahCounterValue(
                title: title,
                value: value,
                minValue: minValue,
                maxValue: maxValue,
                onChanged: onChanged,
              ),
              AyahCounterButton(
                icon: Icons.add,
                onTap: () {
                  if (value < maxValue) {
                    onChanged(value + 1);
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
