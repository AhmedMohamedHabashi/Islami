import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'smart_quran_state.dart';

class SmartQuranCubit extends Cubit<SmartQuranState> {
  SmartQuranCubit() : super(const SmartQuranInitial()) {
    _loadSurahs();
  }

  void _loadSurahs() {
    emit(
      const SmartQuranLoaded(
        surahs: [
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
        ],
        searchQuery: '',
        selectedFilter: 'المحفوظة',
        selectedMode: 'التسميع بالأخطاء الاصطناعية',
        startAyah: 1,
        endAyah: 15,
      ),
    );
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

  void changeStartAyah(int value) {
    final current = _currentState;

    emit(
      current.copyWith(
        startAyah: value,
        endAyah: current.endAyah < value ? value : current.endAyah,
      ),
    );
  }

  void changeEndAyah(int value) {
    final current = _currentState;

    emit(
      current.copyWith(
        endAyah: value < current.startAyah ? current.startAyah : value,
      ),
    );
  }
}
