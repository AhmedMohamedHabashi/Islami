import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/features/smart_quran/domain/entities/ayah.dart';
import 'package:islami/features/smart_quran/domain/usecases/get_ayahs_usecase.dart';
part 'recitation_state.dart';

@injectable
class RecitationCubit extends Cubit<RecitationState> {
  final GetAyahsUseCase getAyahsUseCase;

  RecitationCubit({required this.getAyahsUseCase})
    : super(const RecitationInitial());

  Future<void> loadAyahs({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) async {
    emit(const RecitationLoading());

    try {
      final ayahs = await getAyahsUseCase(
        surahNumber: surahNumber,
        startAyah: startAyah,
        endAyah: endAyah,
      );

      if (ayahs.isEmpty) {
        emit(const RecitationError('لم يتم العثور على الآيات'));
        return;
      }

      emit(RecitationLoaded(ayahs: ayahs));
    } catch (error) {
      emit(RecitationError(error.toString()));
    }
  }

  void nextAyah() {
    final currentState = state;

    if (currentState is! RecitationLoaded || !currentState.hasNextAyah) {
      return;
    }

    emit(
      RecitationLoaded(
        ayahs: currentState.ayahs,
        currentAyahIndex: currentState.currentAyahIndex + 1,
      ),
    );
  }

  void previousAyah() {
    final currentState = state;

    if (currentState is! RecitationLoaded || !currentState.hasPreviousAyah) {
      return;
    }

    emit(
      RecitationLoaded(
        ayahs: currentState.ayahs,
        currentAyahIndex: currentState.currentAyahIndex - 1,
      ),
    );
  }
}
