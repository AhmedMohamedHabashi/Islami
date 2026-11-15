import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/features/smart_quran/data/datasources/speech_to_text_data_source.dart';
import 'package:islami/features/smart_quran/domain/entities/ayah.dart';
import 'package:islami/features/smart_quran/domain/usecases/get_ayahs_usecase.dart';
part 'recitation_state.dart';

@injectable
class RecitationCubit extends Cubit<RecitationState> {
  final GetAyahsUseCase getAyahsUseCase;
  final SpeechToTextDataSource speechDataSource;

  RecitationCubit({
    required this.getAyahsUseCase,
    required this.speechDataSource,
  }) : super(const RecitationInitial());

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

  Future<bool> initializeSpeech() async {
    final isInitialized = await speechDataSource.initialize(
      onStatus: _onSpeechStatus,
      onError: _onSpeechError,
    );

    return isInitialized;
  }

  Future<void> startListening() async {
    if (state is! RecitationLoaded) return;

    try {
      final isInitialized = await initializeSpeech();

      if (!isInitialized) {
        _updateSpeechError('خدمة التعرف على الكلام غير متاحة');
        return;
      }

      if (state is! RecitationLoaded) return;

      _updateSpeechState(
        (currentState) => currentState.copyWith(
          isListening: true,
          recognizedText: '',
          isFinalResult: false,
          clearSpeechError: true,
        ),
      );

      await speechDataSource.startListening(
        localeId: 'ar_EG',
        onResult: _onSpeechResult,
      );
    } catch (error) {
      _updateSpeechError(error.toString());
    }
  }

  Future<void> stopListening() async {
    try {
      await speechDataSource.stopListening();

      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: false),
      );
    } catch (error) {
      _updateSpeechError(error.toString());
    }
  }

  Future<void> cancelListening() async {
    try {
      await speechDataSource.cancelListening();

      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: false),
      );
    } catch (error) {
      _updateSpeechError(error.toString());
    }
  }

  void _onSpeechResult(String text, bool isFinal) {
    _updateSpeechState(
      (currentState) =>
          currentState.copyWith(recognizedText: text, isFinalResult: isFinal),
    );
  }

  void _onSpeechStatus(String status) {
    if (status == 'listening') {
      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: true),
      );
    } else if (status == 'notListening' || status == 'done') {
      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: false),
      );
    }
  }

  void _onSpeechError(String error) {
    _updateSpeechError(error);
  }

  void _updateSpeechError(String error) {
    _updateSpeechState(
      (currentState) =>
          currentState.copyWith(isListening: false, speechError: error),
    );
  }

  void _updateSpeechState(
    RecitationLoaded Function(RecitationLoaded currentState) update,
  ) {
    final currentState = state;

    if (currentState is! RecitationLoaded || isClosed) return;

    emit(update(currentState));
  }

  void nextAyah() {
    final currentState = state;

    if (currentState is! RecitationLoaded || !currentState.hasNextAyah) {
      return;
    }

    emit(
      currentState.copyWith(
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
      currentState.copyWith(
        currentAyahIndex: currentState.currentAyahIndex - 1,
      ),
    );
  }

  @override
  Future<void> close() async {
    await speechDataSource.cancelListening();
    return super.close();
  }
}
