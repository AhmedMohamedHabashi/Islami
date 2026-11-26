import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/errors/failures.dart';
import 'package:islami/core/utils/helpers/arabic_text_utils.dart';
import 'package:islami/features/home/domain/entities/surah_entity.dart';
import 'package:islami/features/home/domain/usecases/get_home_recent_surahs_usecase.dart';
import 'package:islami/features/home/domain/usecases/get_home_surahs_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetHomeSurahsUseCase getSurahs;
  final GetHomeRecentSurahsUseCase getRecentSurahs;

  HomeCubit({required this.getSurahs, required this.getRecentSurahs})
    : super(const HomeState());

  Future<void> load() async {
    emit(state.copyWith(status: HomeStatus.loading));
    try {
      final surahs = await getSurahs();
      final recent = await getRecentSurahs();
      emit(
        state.copyWith(
          status: HomeStatus.success,
          allSurahs: surahs,
          recentSurahs: recent,
          filteredSurahs: surahs,
        ),
      );
    } on Failure catch (e) {
      emit(state.copyWith(status: HomeStatus.failure, errorMessage: e.message));
    }
  }

  void search(String query) {
    final q = ArabicTextUtils.normalize(query);
    final result = q.isEmpty
        ? state.allSurahs
        : state.allSurahs.where((s) {
            return s.nameEn.toLowerCase().contains(q) ||
                ArabicTextUtils.normalize(s.nameAr).contains(q) ||
                s.number.toString() == q;
          }).toList();

    emit(state.copyWith(query: query, filteredSurahs: result));
  }
}
