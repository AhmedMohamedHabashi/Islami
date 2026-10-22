import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_icons.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class CustomRadioBottom extends StatelessWidget {
  const CustomRadioBottom({
    super.key,
    required this.selectedIndex,
    this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  static const _icons = [
    AppIcons.timeIcon,
    AppIcons.radioIcon,
    AppIcons.sbhaIcon,
    AppIcons.hadithIcon,
    AppIcons.quranIcon,
  ];
  static const _labels = ['Time', 'Radio', 'Tasbih', 'Hadith', 'Quran'];
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 65,
          child: Row(
            children: List.generate(_icons.length, (index) {
              final isSelected = selectedIndex == index;
              return Expanded(
                child: InkWell(
                  onTap: () => onItemSelected?.call(index),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          padding: EdgeInsets.symmetric(
                            horizontal: isSelected ? 16 : 0,
                            vertical: isSelected ? 6 : 0,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Image.asset(
                            _icons[index],
                            width: 20,
                            height: 20,
                            color: isSelected ? AppColors.white : null,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(height: 2),
                          Text(
                            _labels[index],
                            style: AppTextStyles.caption12.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
