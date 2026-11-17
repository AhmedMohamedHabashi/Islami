import 'dart:async';
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

  final Stopwatch _stopwatch = Stopwatch();
  Timer? _durationTimer;

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
    _resetDuration();
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

      // Start the timer only if listening is still active.
      if (state is RecitationLoaded &&
          (state as RecitationLoaded).isListening) {
        _startDurationTimer();
      }
    } catch (_) {
      _updateSpeechError(AppErrors.speechRecognitionError);
    }
  }

  // Stop Listening
  Future<void> stopListening() async {
    try {
      await speechDataSource.stopListening();

      _pauseDurationTimer();

      _updateSpeechState(
        (currentState) => currentState.copyWith(
          isListening: false,
          durationInSeconds: _stopwatch.elapsed.inSeconds,
        ),
      );
    } catch (_) {
      _updateSpeechError(AppErrors.speechRecognitionError);
    }
  }

  // Cancel Listening
  Future<void> cancelListening() async {
    try {
      await speechDataSource.cancelListening();

      _pauseDurationTimer();

      _updateSpeechState(
        (currentState) => currentState.copyWith(
          isListening: false,
          durationInSeconds: _stopwatch.elapsed.inSeconds,
        ),
      );
    } catch (_) {
      _updateSpeechError(AppErrors.speechRecognitionError);
    }
  }

  // Start Duration Timer
  void _startDurationTimer() {
    if (isClosed || _stopwatch.isRunning) return;

    _stopwatch.start();

    _durationTimer ??= Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;

      _updateSpeechState(
        (currentState) => currentState.copyWith(
          durationInSeconds: _stopwatch.elapsed.inSeconds,
        ),
      );
    });
  }

  // Pause Duration Timer
  void _pauseDurationTimer() {
    _stopwatch.stop();
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  // Reset Duration
  void _resetDuration() {
    _pauseDurationTimer();
    _stopwatch.reset();
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
      _startDurationTimer();

      _updateSpeechState(
        (currentState) => currentState.copyWith(isListening: true),
      );
    } else if (status == 'notListening' || status == 'done') {
      _pauseDurationTimer();

      _updateSpeechState(
        (currentState) => currentState.copyWith(
          isListening: false,
          durationInSeconds: _stopwatch.elapsed.inSeconds,
        ),
      );
    }
  }

  // Speech Recognition Error
  void _onSpeechError(String error) {
    _updateSpeechError(AppErrors.speechRecognitionError);
  }

  // Update Speech Error
  void _updateSpeechError(String error) {
    _pauseDurationTimer();

    _updateSpeechState(
      (currentState) => currentState.copyWith(
        isListening: false,
        durationInSeconds: _stopwatch.elapsed.inSeconds,
        speechError: error,
      ),
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

  // Previous Ayah
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
    _pauseDurationTimer();

    await speechDataSource.cancelListening();

    return super.close();
  }
}
