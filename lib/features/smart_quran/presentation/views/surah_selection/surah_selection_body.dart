import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/shared/widgets/header/islami_header.dart';
import 'package:islami/core/shared/widgets/text_fields/custom_search_field.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/ayah_range_selector.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_card.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_continue_card.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_empty_state.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_filters.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_section_title.dart';

class SurahSelectionBody extends StatelessWidget {
  const SurahSelectionBody({
    super.key,
    required this.searchController,
    required this.surahs,
    required this.selectedFilter,
    required this.selectedMode,
    required this.startAyah,
    required this.endAyah,
    required this.onSearchChanged,
    required this.onFilterChanged,
    required this.onStartAyahChanged,
    required this.onEndAyahChanged,
    required this.onModeChanged,
    required this.onStartRecitation,
  });

  final TextEditingController searchController;
  final List<Map<String, dynamic>> surahs;

  final String selectedFilter;
  final String selectedMode;

  final int startAyah;
  final int endAyah;

  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String> onFilterChanged;
  final ValueChanged<int> onStartAyahChanged;
  final ValueChanged<int> onEndAyahChanged;
  final ValueChanged<String> onModeChanged;
  final VoidCallback onStartRecitation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IslamiHeader(small: true),
          SizedBox(height: 12.h),

          const SurahContinueCard(),
          SizedBox(height: 12.h),

          _buildSearchField(l10n.searchSurahHint),
          SizedBox(height: 12.h),

          SurahFilters(
            selectedFilter: selectedFilter,
            onFilterChanged: onFilterChanged,
          ),
          SizedBox(height: 12.h),

          AyahRangeSelector(
            startAyah: startAyah,
            endAyah: endAyah,
            selectedMode: selectedMode,
            onStartAyahChanged: onStartAyahChanged,
            onEndAyahChanged: onEndAyahChanged,
            onModeChanged: onModeChanged,
          ),
          SizedBox(height: 12.h),

          SurahSectionTitle(surahCount: surahs.length),
          SizedBox(height: 12.h),

          if (surahs.isEmpty)
            const SurahEmptyState()
          else
            ...surahs.map((surah) => SurahCard(surah: surah)),

          SizedBox(height: 20.h),

          CustomActionButton(
            title: l10n.startRecitation,
            isPrimary: true,
            icon: Icons.mic_rounded,
            onPressed: onStartRecitation,
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSearchField(String hintText) {
    return CustomSearchField(
      controller: searchController,
      onChanged: onSearchChanged,
      hintText: hintText,
    );
  }
}
