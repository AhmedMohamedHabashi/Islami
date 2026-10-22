class RadioState {
  final int selectedTabIndex;
  final String? playingItemTitle;
  final Set<String> mutedItemTitles;

  const RadioState({
    this.selectedTabIndex = 0,
    this.playingItemTitle,
    this.mutedItemTitles = const {},
  });

  RadioState copyWith({
    int? selectedTabIndex,
    String? playingItemTitle,
    bool clearPlaying = false,
    Set<String>? mutedItemTitles,
  }) {
    return RadioState(
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      playingItemTitle: clearPlaying
          ? null
          : (playingItemTitle ?? this.playingItemTitle),
      mutedItemTitles: mutedItemTitles ?? this.mutedItemTitles,
    );
  }
}
