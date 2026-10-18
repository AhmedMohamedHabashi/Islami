import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class RadioTabBar extends StatelessWidget {
  const RadioTabBar({
    super.key,
    required this.selectedIndex,
    this.onTabChanged,
  });

  final int selectedIndex;
  final ValueChanged<int>? onTabChanged;

  static const _tabs = ['Reciters', 'Radio'];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(_tabs.length, (index) {
        final isSelected = selectedIndex == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: index == 0 ? 8 : 0),
            child: Material(
              color: isSelected ? AppColors.semiTransparent : AppColors.primary,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(14),
                onTap: () => onTabChanged?.call(index),
                child: SizedBox(
                  height: 40,
                  child: Center(
                    child: Text(
                      _tabs[index],
                      style: AppTextStyles.body16.copyWith(
                        color: isSelected ? AppColors.white : AppColors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
