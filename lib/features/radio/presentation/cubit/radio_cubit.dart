import 'package:flutter_bloc/flutter_bloc.dart';
import 'radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(const RadioState());

  void changeTab(int index) {
    emit(state.copyWith(selectedTabIndex: index));
  }

  void togglePlay(String title) {
    if (state.playingItemTitle == title) {
      emit(state.copyWith(clearPlaying: true));
    } else {
      emit(state.copyWith(playingItemTitle: title));
    }
  }

  void toggleMute(String title) {
    final muted = {...state.mutedItemTitles};
    if (!muted.add(title)) muted.remove(title);
    emit(state.copyWith(mutedItemTitles: muted));
  }
}
