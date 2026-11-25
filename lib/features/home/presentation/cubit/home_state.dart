part of 'home_cubit.dart';

enum HomeStatus { initial, loading, success, failure }

class HomeState extends Equatable {
  final HomeStatus status;
  final List<SurahEntity> allSurahs;
  final List<SurahEntity> recentSurahs;
  final List<SurahEntity> filteredSurahs;
  final String query;
  final String errorMessage;

  const HomeState({
    this.status = HomeStatus.initial,
    this.allSurahs = const [],
    this.recentSurahs = const [],
    this.filteredSurahs = const [],
    this.query = '',
    this.errorMessage = '',
  });

  bool get isSearching => query.trim().isNotEmpty;

  HomeState copyWith({
    HomeStatus? status,
    List<SurahEntity>? allSurahs,
    List<SurahEntity>? recentSurahs,
    List<SurahEntity>? filteredSurahs,
    String? query,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      allSurahs: allSurahs ?? this.allSurahs,
      recentSurahs: recentSurahs ?? this.recentSurahs,
      filteredSurahs: filteredSurahs ?? this.filteredSurahs,
      query: query ?? this.query,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    allSurahs,
    recentSurahs,
    filteredSurahs,
    query,
    errorMessage,
  ];
}
