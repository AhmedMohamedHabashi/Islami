import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
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

  static const _tabs = ['Radio', 'Reciters'];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tabs = [l10n.radio, l10n.reciters];
    return Row(
      children: List.generate(_tabs.length, (index) {
        final isSelected = selectedIndex == index;

        return Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: index == 0 ? 8 : 0),
            child: Material(
              color: isSelected ? AppColors.primary : AppColors.primary,
              borderRadius: BorderRadius.circular(14),
              child: InkWell(
                borderRadius: BorderRadius.circular(12.r),
                onTap: () => onTabChanged?.call(index),
                child: SizedBox(
                  height: 40.h,
                  child: Center(
                    child: Text(
                      _tabs[index],
                      style: AppTextStyles.body16.copyWith(
                        color: isSelected ? AppColors.black : AppColors.white,
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
