import 'dart:async';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:islami/core/errors/app_errors.dart';
import 'package:islami/core/errors/failures.dart';
import 'package:islami/core/services/voice_activity_detector.dart';
import 'package:islami/features/smart_quran/domain/entities/ayah.dart';
import 'package:islami/features/smart_quran/domain/repo/audio_recording_repository.dart';
import 'package:islami/features/smart_quran/domain/usecases/get_ayahs_usecase.dart';

part 'recitation_state.dart';

@injectable
class RecitationCubit extends Cubit<RecitationState> {
  final GetAyahsUseCase getAyahsUseCase;
  final AudioRecordingRepository audioRecordingRepository;

  final VoiceActivityDetector _voiceActivityDetector = VoiceActivityDetector(
    silenceThreshold: 500,
    silenceLimit: const Duration(seconds: 3),
  );

  final Stopwatch _stopwatch = Stopwatch();

  StreamSubscription<Uint8List>? _audioSubscription;
  Timer? _durationTimer;

  Future<void>? _stopFuture;

  bool _shouldKeepRecording = false;
  bool _isStopping = false;

  RecitationCubit({
    required this.getAyahsUseCase,
    required this.audioRecordingRepository,
  }) : super(const RecitationInitial());

  Future<void> loadAyahs({
    required int surahNumber,
    required int startAyah,
    required int endAyah,
  }) async {
    if (_shouldKeepRecording || audioRecordingRepository.isRecording) {
      await stopListening();
    }

    if (isClosed) return;

    _resetDuration();
    _voiceActivityDetector.reset();

    emit(const RecitationLoading());

    try {
      final ayahs = await getAyahsUseCase(
        surahNumber: surahNumber,
        startAyah: startAyah,
        endAyah: endAyah,
      );

      if (isClosed) return;

      if (ayahs.isEmpty) {
        emit(const RecitationError(AppErrors.notFound));
        return;
      }

      emit(RecitationLoaded(ayahs: ayahs));
    } on Failure catch (failure) {
      if (!isClosed) {
        emit(RecitationError(failure.message));
      }
    } catch (_) {
      if (!isClosed) {
        emit(const RecitationError(AppErrors.unexpectedError));
      }
    }
  }

  Future<void> startListening() async {
    if (state is! RecitationLoaded ||
        _shouldKeepRecording ||
        _isStopping ||
        isClosed) {
      return;
    }

    _shouldKeepRecording = true;

    _resetDuration();
    _voiceActivityDetector.reset();

    _updateRecordingState(
      (currentState) => currentState.copyWith(
        isRecording: true,
        isListening: false,
        clearRecordingError: true,
        durationInSeconds: 0,
      ),
    );

    try {
      final audioStream = await audioRecordingRepository.startRecording();

      if (!_shouldKeepRecording || isClosed) {
        if (audioRecordingRepository.isRecording) {
          await audioRecordingRepository.stopRecording();
        }
        return;
      }

      _audioSubscription = audioStream.listen(
        _onAudioChunk,
        onError: _onAudioStreamError,
        onDone: _onAudioStreamDone,
        cancelOnError: false,
      );

      _startDurationTimer();

      _updateRecordingState(
        (currentState) =>
            currentState.copyWith(isRecording: true, isListening: true),
      );
    } on Failure catch (failure) {
      await _stopRecording(error: failure.message);
    } catch (_) {
      await _stopRecording(error: AppErrors.audioRecordingError);
    }
  }

  void _onAudioChunk(Uint8List audioData) {
    if (!_shouldKeepRecording || _isStopping || isClosed) return;

    _voiceActivityDetector.processChunk(audioData);

    if (_voiceActivityDetector.hasReachedSilenceLimit) {
      unawaited(stopListening());
    }
  }

  void _onAudioStreamError(Object error) {
    if (!_shouldKeepRecording || isClosed) return;

    unawaited(_stopRecording(error: AppErrors.audioRecordingError));
  }

  void _onAudioStreamDone() {
    if (!_shouldKeepRecording || isClosed) return;

    unawaited(_stopRecording(error: AppErrors.audioRecordingError));
  }

  Future<void> stopListening() async {
    await _stopRecording();
  }

  Future<void> _stopRecording({String? error}) async {
    final existingStop = _stopFuture;

    if (existingStop != null) {
      await existingStop;
      return;
    }

    if (isClosed) return;

    if (!_shouldKeepRecording && !audioRecordingRepository.isRecording) {
      return;
    }

    _isStopping = true;
    _shouldKeepRecording = false;

    final stopFuture = _performStopRecording(error: error);
    _stopFuture = stopFuture;

    try {
      await stopFuture;
    } finally {
      _stopFuture = null;
      _isStopping = false;
    }
  }

  Future<void> _performStopRecording({String? error}) async {
    _pauseDurationTimer();

    try {
      await _audioSubscription?.cancel();
      _audioSubscription = null;

      if (audioRecordingRepository.isRecording) {
        await audioRecordingRepository.stopRecording();
      }
    } on Failure catch (failure) {
      error ??= failure.message;
    } catch (_) {
      error ??= AppErrors.audioRecordingError;
    } finally {
      _stopwatch.stop();

      if (!isClosed) {
        _updateRecordingState(
          (currentState) => currentState.copyWith(
            isRecording: false,
            isListening: false,
            durationInSeconds: _stopwatch.elapsed.inSeconds,
            recordingError: error,
          ),
        );
      }
    }
  }

  void _startDurationTimer() {
    if (isClosed || _stopwatch.isRunning) return;

    _stopwatch.start();
    _durationTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed || !_shouldKeepRecording) return;

      _updateRecordingState(
        (currentState) => currentState.copyWith(
          durationInSeconds: _stopwatch.elapsed.inSeconds,
        ),
      );
    });
  }

  void _pauseDurationTimer() {
    _stopwatch.stop();
    _durationTimer?.cancel();
    _durationTimer = null;
  }

  void _resetDuration() {
    _pauseDurationTimer();
    _stopwatch.reset();
  }

  void _updateRecordingState(
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
    _shouldKeepRecording = false;
    await _stopRecording();
    _pauseDurationTimer();

    await _audioSubscription?.cancel();
    _audioSubscription = null;

    try {
      if (audioRecordingRepository.isRecording) {
        await audioRecordingRepository.stopRecording();
      }
    } catch (_) {
      // Ignore errors while closing.
    }

    return super.close();
  }
}
