part of 'recitation_cubit.dart';

sealed class RecitationState extends Equatable {
  const RecitationState();

  @override
  List<Object?> get props => [];
}

final class RecitationInitial extends RecitationState {
  const RecitationInitial();
}

final class RecitationLoading extends RecitationState {
  const RecitationLoading();
}

final class RecitationError extends RecitationState {
  final String message;

  const RecitationError(this.message);

  @override
  List<Object?> get props => [message];
}

final class RecitationLoaded extends RecitationState {
  final List<Ayah> ayahs;
  final int currentAyahIndex;
  final bool isRecording;
  final bool isListening;
  final String? recordingError;
  final int durationInSeconds;

  const RecitationLoaded({
    required this.ayahs,
    this.currentAyahIndex = 0,
    this.isRecording = false,
    this.isListening = false,
    this.recordingError,
    this.durationInSeconds = 0,
  });

  Ayah? get currentAyah {
    if (ayahs.isEmpty) return null;
    return ayahs[currentAyahIndex];
  }

  bool get hasNextAyah => currentAyahIndex < ayahs.length - 1;

  bool get hasPreviousAyah => currentAyahIndex > 0;

  String get formattedDuration {
    final minutes = durationInSeconds ~/ 60;
    final seconds = durationInSeconds % 60;

    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  RecitationLoaded copyWith({
    List<Ayah>? ayahs,
    int? currentAyahIndex,
    bool? isRecording,
    bool? isListening,
    String? recordingError,
    int? durationInSeconds,
    bool clearRecordingError = false,
  }) {
    return RecitationLoaded(
      ayahs: ayahs ?? this.ayahs,
      currentAyahIndex: currentAyahIndex ?? this.currentAyahIndex,
      isRecording: isRecording ?? this.isRecording,
      isListening: isListening ?? this.isListening,
      recordingError: clearRecordingError
          ? null
          : recordingError ?? this.recordingError,
      durationInSeconds: durationInSeconds ?? this.durationInSeconds,
    );
  }

  @override
  List<Object?> get props => [
    ayahs,
    currentAyahIndex,
    isRecording,
    isListening,
    recordingError,
    durationInSeconds,
  ];
}
