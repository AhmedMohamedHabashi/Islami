import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_icons.dart';
import 'package:islami/config/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';

class CustomRadioBottom extends StatelessWidget {
  const CustomRadioBottom({
    super.key,
    required this.selectedIndex,
    this.onItemSelected,
  });

  final int selectedIndex;
  final ValueChanged<int>? onItemSelected;

  static const _icons = [
    AppIcons.quranIcon,
    AppIcons.hadithIcon,
    AppIcons.sbhaIcon,
    AppIcons.radioIcon,
    AppIcons.timeIcon,
  ];
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final labels = [
      l10n.quran,
      l10n.hadith,
      l10n.tasbih,
      l10n.radio,
      l10n.time,
    ];
    return ColoredBox(
      color: AppColors.primary,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSizes.size64H,
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
                            horizontal: isSelected ? AppSizes.size16W : 0,
                            vertical: isSelected ? AppSizes.size6H : 0,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primary
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              AppSizes.radius20,
                            ),
                          ),
                          child: Image.asset(
                            _icons[index],
                            width: AppSizes.size20W,
                            height: AppSizes.size20H,
                            color: isSelected ? AppColors.white : null,
                          ),
                        ),
                        if (isSelected) ...[
                          SizedBox(height: AppSizes.size2H),
                          Text(
                            labels[index],
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
