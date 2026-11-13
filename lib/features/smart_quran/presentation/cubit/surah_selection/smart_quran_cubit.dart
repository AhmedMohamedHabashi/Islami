import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/features/smart_quran/domain/entities/surah.dart';
import 'package:islami/features/smart_quran/domain/usecases/get_surahs_usecase.dart';

part 'smart_quran_state.dart';

@injectable
class SmartQuranCubit extends Cubit<SmartQuranState> {
  final GetSurahsUseCase getSurahsUseCase;

  SmartQuranCubit({required this.getSurahsUseCase})
    : super(const SmartQuranInitial()) {
    loadSurahs();
  }

  Future<void> loadSurahs() async {
    emit(const SmartQuranLoading());

    try {
      final surahs = await getSurahsUseCase();

      emit(
        SmartQuranLoaded(
          surahs: surahs,
          searchQuery: '',
          selectedFilter: 'المقترحة',
          selectedMode: 'error',
          startAyah: 1,
          endAyah: 15,
        ),
      );
    } catch (error) {
      emit(SmartQuranError(error.toString()));
    }
  }

  SmartQuranLoaded get _currentState => state as SmartQuranLoaded;

  void searchSurahs(String query) {
    emit(_currentState.copyWith(searchQuery: query));
  }

  void changeFilter(String filter) {
    emit(_currentState.copyWith(selectedFilter: filter));
  }

  void changeMode(String mode) {
    emit(_currentState.copyWith(selectedMode: mode));
  }

  // Select a Surah and adjust the Ayah range to its maximum Ayah count.
  void selectSurah(Surah surah) {
    final current = _currentState;
    final maxAyah = surah.numberOfAyahs;
    final endAyah = maxAyah < 15 ? maxAyah : 15;

    emit(
      current.copyWith(selectedSurah: surah, startAyah: 1, endAyah: endAyah),
    );
  }

  void changeStartAyah(int value) {
    final current = _currentState;
    final maxAyah = current.maxAyah;

    final newStart = maxAyah == null
        ? value.clamp(1, current.endAyah)
        : value.clamp(1, maxAyah);

    emit(
      current.copyWith(
        startAyah: newStart,
        endAyah: current.endAyah < newStart ? newStart : current.endAyah,
      ),
    );
  }

  void changeEndAyah(int value) {
    final current = _currentState;
    final maxAyah = current.maxAyah;

    final newEnd = maxAyah == null
        ? value.clamp(current.startAyah, 999)
        : value.clamp(current.startAyah, maxAyah);

    emit(current.copyWith(endAyah: newEnd));
  }
}
