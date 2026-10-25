import 'package:flutter/material.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/surah_selection_body.dart';

class SurahSelectionView extends StatefulWidget {
  const SurahSelectionView({super.key});

  @override
  State<SurahSelectionView> createState() => _SurahSelectionViewState();
}

class _SurahSelectionViewState extends State<SurahSelectionView> {
  final TextEditingController _searchController = TextEditingController();

  String _selectedFilter = 'المحفوظة';
  String _selectedMode = 'التسميع بالأخطاء الاصطناعية';

  int _startAyah = 1;
  int _endAyah = 15;

  final List<Map<String, dynamic>> _surahs = [
    {
      'number': 18,
      'name': 'سورة الكهف',
      'verses': 110,
      'type': 'مكية',
      'progress': 85,
      'saved': true,
    },
    {
      'number': 19,
      'name': 'سورة مريم',
      'verses': 98,
      'type': 'مكية',
      'progress': 60,
      'saved': true,
    },
    {
      'number': 20,
      'name': 'سورة طه',
      'verses': 135,
      'type': 'مكية',
      'progress': 0,
      'saved': false,
    },
    {
      'number': 21,
      'name': 'سورة الأنبياء',
      'verses': 112,
      'type': 'مكية',
      'progress': 0,
      'saved': false,
    },
  ];

  List<Map<String, dynamic>> get _filteredSurahs {
    final query = _searchController.text.trim();

    return _surahs.where((surah) {
      final matchesSearch = (surah['name'] as String).contains(query);

      final matchesFilter = switch (_selectedFilter) {
        'المحفوظة' => surah['saved'] == true,
        'المقترحة' => true,
        'المكية' => surah['type'] == 'مكية',
        'المدنية' => surah['type'] == 'مدنية',
        _ => true,
      };

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.primaryBackground,
        body: SafeArea(
          child: SurahSelectionBody(
            searchController: _searchController,
            surahs: _filteredSurahs,
            selectedFilter: _selectedFilter,
            selectedMode: _selectedMode,
            startAyah: _startAyah,
            endAyah: _endAyah,
            onSearchChanged: (_) => setState(() {}),
            onFilterChanged: (filter) {
              setState(() => _selectedFilter = filter);
            },
            onStartAyahChanged: (value) {
              setState(() {
                _startAyah = value;
                if (_endAyah < value) {
                  _endAyah = value;
                }
              });
            },
            onEndAyahChanged: (value) {
              setState(() {
                _endAyah = value < _startAyah ? _startAyah : value;
              });
            },
            onModeChanged: (mode) {
              setState(() => _selectedMode = mode);
            },
          ),
        ),
      ),
    );
  }
}
