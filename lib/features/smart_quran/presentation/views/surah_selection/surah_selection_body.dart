import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/shared/widgets/header/islami_header.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
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
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const IslamiHeader.compact(showMosque: true),
          SizedBox(height: 12.h),

          const SurahContinueCard(),
          SizedBox(height: 12.h),

          _buildSearchField(),
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

          ElevatedButton.icon(
            onPressed: onStartRecitation,
            icon: const Icon(Icons.mic_rounded),
            label: const Text('ابدأ التسميع'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              minimumSize: Size(double.infinity, 48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: searchController,
      onChanged: onSearchChanged,
      style: const TextStyle(color: AppColors.white),
      decoration: InputDecoration(
        hintText: 'ابحث عن اسم السورة أو الجزء...',
        hintStyle: AppTextStyles.regular.copyWith(
          color: AppColors.white.withValues(alpha: 0.45),
        ),
        prefixIcon: Icon(
          Icons.search_rounded,
          color: AppColors.primary,
          size: 20.sp,
        ),
        filled: true,
        fillColor: AppColors.black.withValues(alpha: 0.22),
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.white.withValues(alpha: 0.15),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: AppColors.white.withValues(alpha: 0.15),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
      ),
    );
  }
}
