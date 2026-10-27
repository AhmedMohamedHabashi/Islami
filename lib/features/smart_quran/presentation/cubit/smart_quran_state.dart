part of 'smart_quran_cubit.dart';

sealed class SmartQuranState extends Equatable {
  const SmartQuranState();

  @override
  List<Object?> get props => [];
}

final class SmartQuranInitial extends SmartQuranState {
  const SmartQuranInitial();
}

final class SmartQuranLoaded extends SmartQuranState {
  final List<Map<String, dynamic>> surahs;
  final String searchQuery;
  final String selectedFilter;
  final String selectedMode;
  final int startAyah;
  final int endAyah;

  const SmartQuranLoaded({
    required this.surahs,
    required this.searchQuery,
    required this.selectedFilter,
    required this.selectedMode,
    required this.startAyah,
    required this.endAyah,
  });

  SmartQuranLoaded copyWith({
    List<Map<String, dynamic>>? surahs,
    String? searchQuery,
    String? selectedFilter,
    String? selectedMode,
    int? startAyah,
    int? endAyah,
  }) {
    return SmartQuranLoaded(
      surahs: surahs ?? this.surahs,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedMode: selectedMode ?? this.selectedMode,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
    );
  }

  List<Map<String, dynamic>> get filteredSurahs {
    return surahs.where((surah) {
      final name = surah['name'] as String;

      final matchesSearch = name.contains(searchQuery);

      final matchesFilter = switch (selectedFilter) {
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
  List<Object?> get props => [
    surahs,
    searchQuery,
    selectedFilter,
    selectedMode,
    startAyah,
    endAyah,
  ];
}
