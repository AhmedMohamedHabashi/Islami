import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/features/smart_quran/domain/entities/surah.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_card.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_empty_state.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_list_expansion_button.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/widgets/surah_section_title.dart';

class SurahListSection extends StatefulWidget {
  final List<Surah> surahs;
  final Surah? selectedSurah;
  final ValueChanged<Surah> onSurahSelected;
  final bool isSearching;

  const SurahListSection({
    super.key,
    required this.surahs,
    required this.selectedSurah,
    required this.onSurahSelected,
    required this.isSearching,
  });

  @override
  State<SurahListSection> createState() => _SurahListSectionState();
}

class _SurahListSectionState extends State<SurahListSection> {
  static const int _initialSurahCount = 10;
  static const int _pageSize = 10;

  int _visibleCount = _initialSurahCount;

  @override
  void didUpdateWidget(covariant SurahListSection oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset the visible count when search starts or ends.
    if (oldWidget.isSearching != widget.isSearching) {
      _visibleCount = _initialSurahCount;
    }
  }

  List<Surah> get _visibleSurahs {
    if (widget.isSearching) {
      return widget.surahs;
    }

    return widget.surahs.take(_visibleCount).toList();
  }

  bool get _hasMoreSurahs {
    return !widget.isSearching && widget.surahs.length > _visibleCount;
  }

  bool get _canShowLess {
    return !widget.isSearching && _visibleCount > _initialSurahCount;
  }

  void _showMore() {
    setState(() {
      _visibleCount = (_visibleCount + _pageSize).clamp(
        0,
        widget.surahs.length,
      );
    });
  }

  void _showLess() {
    setState(() {
      _visibleCount = _initialSurahCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleSurahs = _visibleSurahs;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SurahSectionTitle(surahCount: widget.surahs.length),
        SizedBox(height: 12.h),

        if (widget.surahs.isEmpty)
          const SurahEmptyState()
        else
          ...visibleSurahs.map(
            (surah) => SurahCard(
              surah: surah,
              isSelected: widget.selectedSurah?.number == surah.number,
              onTap: () => widget.onSurahSelected(surah),
            ),
          ),

        if (_hasMoreSurahs) ...[
          SizedBox(height: 12.h),
          SurahListExpansionButton(onPressed: _showMore),
        ],

        if (_canShowLess) ...[
          SizedBox(height: 8.h),
          SurahListExpansionButton(onPressed: _showLess, showLess: true),
        ],
      ],
    );
  }
}
