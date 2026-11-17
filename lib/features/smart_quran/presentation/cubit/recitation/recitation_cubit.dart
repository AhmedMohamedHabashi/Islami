import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/failures.dart';
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

  // Load Ayahs
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
        emit(const RecitationError(AppErrors.notFound));
        return;
      }

      emit(RecitationLoaded(ayahs: ayahs));
    } on Failure catch (failure) {
      emit(RecitationError(failure.message));
    } catch (_) {
      emit(const RecitationError(AppErrors.unexpectedError));
    }
  }

  // Initialize Speech Recognition
  Future<bool> initializeSpeech() async {
    return speechDataSource.initialize(
      onStatus: _onSpeechStatus,
      onError: _onSpeechError,
    );
  }

  // Start Listening
  Future<void> startListening() async {
    if (state is! RecitationLoaded) return;

    try {
      final isInitialized = await initializeSpeech();

      if (!isInitialized) {
        _updateSpeechError(AppErrors.speechUnavailable);
        return;
      }

      if (state is! RecitationLoaded || isClosed) return;

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
    } catch (_) {
      _updateSpeechError(AppErrors.speechRecognitionError);
    }
  }

  // Stop Listening
  Future<void> stopListening() async {
    try {
      await speechDataSource.stopListening();

      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: false),
      );
    } catch (_) {
      _updateSpeechError(AppErrors.speechRecognitionError);
    }
  }

  // Cancel Listening
  Future<void> cancelListening() async {
    try {
      await speechDataSource.cancelListening();

      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: false),
      );
    } catch (_) {
      _updateSpeechError(AppErrors.speechRecognitionError);
    }
  }

  // Speech Recognition Result
  void _onSpeechResult(String text, bool isFinal) {
    _updateSpeechState(
      (currentState) =>
          currentState.copyWith(recognizedText: text, isFinalResult: isFinal),
    );
  }

  // Speech Recognition Status
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

  // Speech Recognition Error
  void _onSpeechError(String error) {
    _updateSpeechError(AppErrors.speechRecognitionError);
  }

  // Update Speech Error
  void _updateSpeechError(String error) {
    _updateSpeechState(
      (currentState) =>
          currentState.copyWith(isListening: false, speechError: error),
    );
  }

  // Update Speech State
  void _updateSpeechState(
    RecitationLoaded Function(RecitationLoaded currentState) update,
  ) {
    final currentState = state;

    if (currentState is! RecitationLoaded || isClosed) return;

    emit(update(currentState));
  }

  // Next Ayah
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
