import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/config/localization/l10n/app_localizations.dart';
import 'package:islami/core/constants/app_strings.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';

class SurahFilters extends StatelessWidget {
  final String selectedFilter;
  final ValueChanged<String> onFilterChanged;

  const SurahFilters({
    super.key,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final filters = [
      (AppStrings.saved, l10n.saved),
      (AppStrings.suggested, l10n.suggested),
      (AppStrings.meccan, l10n.meccan),
      (AppStrings.medinan, l10n.medinan),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final selected = filter.$1 == selectedFilter;

          return Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: ChoiceChip(
              label: Text(filter.$2),
              selected: selected,
              onSelected: (_) => onFilterChanged(filter.$1),
              showCheckmark: false,
              selectedColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              backgroundColor: AppColors.primaryBackground,
              labelStyle: AppTextStyles.body12.copyWith(
                color: selected ? AppColors.black : AppColors.white,
                fontWeight: selected ? FontWeight.bold : FontWeight.normal,
              ),
              side: BorderSide(
                color: selected
                    ? AppColors.primary
                    : AppColors.primary.withValues(alpha: 0.35),
              ),
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              visualDensity: VisualDensity.compact,
            ),
          );
        }).toList(),
      ),
    );
  }
}
