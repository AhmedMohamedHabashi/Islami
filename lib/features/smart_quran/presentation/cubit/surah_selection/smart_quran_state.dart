part of 'smart_quran_cubit.dart';

sealed class SmartQuranState extends Equatable {
  const SmartQuranState();

  @override
  List<Object?> get props => [];
}

final class SmartQuranInitial extends SmartQuranState {
  const SmartQuranInitial();
}

final class SmartQuranLoading extends SmartQuranState {
  const SmartQuranLoading();
}

final class SmartQuranError extends SmartQuranState {
  final String message;

  const SmartQuranError(this.message);

  @override
  List<Object?> get props => [message];
}

final class SmartQuranLoaded extends SmartQuranState {
  final List<Surah> surahs;
  final String searchQuery;
  final String selectedFilter;
  final String selectedMode;
  final int startAyah;
  final int endAyah;

  // The Surah selected by the user.
  final Surah? selectedSurah;

  const SmartQuranLoaded({
    required this.surahs,
    required this.searchQuery,
    required this.selectedFilter,
    required this.selectedMode,
    required this.startAyah,
    required this.endAyah,
    this.selectedSurah,
  });

  // Maximum Ayah number for the selected Surah.
  int? get maxAyah => selectedSurah?.numberOfAyahs;

  SmartQuranLoaded copyWith({
    List<Surah>? surahs,
    String? searchQuery,
    String? selectedFilter,
    String? selectedMode,
    int? startAyah,
    int? endAyah,
    Surah? selectedSurah,
  }) {
    return SmartQuranLoaded(
      surahs: surahs ?? this.surahs,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      selectedMode: selectedMode ?? this.selectedMode,
      startAyah: startAyah ?? this.startAyah,
      endAyah: endAyah ?? this.endAyah,
      selectedSurah: selectedSurah ?? this.selectedSurah,
    );
  }

  List<Surah> get filteredSurahs {
    return surahs.where((surah) {
      final matchesSearch = surah.name.contains(searchQuery);

      final matchesFilter = switch (selectedFilter) {
        'المحفوظة' => surah.isSaved,
        'المقترحة' => true,
        'المكية' => surah.revelationType == 'Meccan',
        'المدنية' => surah.revelationType == 'Medinan',
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
    selectedSurah,
  ];
}
