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

  final bool isListening;
  final String recognizedText;
  final bool isFinalResult;
  final String? speechError;

  const RecitationLoaded({
    required this.ayahs,
    this.currentAyahIndex = 0,
    this.isListening = false,
    this.recognizedText = '',
    this.isFinalResult = false,
    this.speechError,
  });

  Ayah? get currentAyah {
    if (ayahs.isEmpty) return null;
    return ayahs[currentAyahIndex];
  }

  bool get hasNextAyah => currentAyahIndex < ayahs.length - 1;

  bool get hasPreviousAyah => currentAyahIndex > 0;

  RecitationLoaded copyWith({
    List<Ayah>? ayahs,
    int? currentAyahIndex,
    bool? isListening,
    String? recognizedText,
    bool? isFinalResult,
    String? speechError,
    bool clearSpeechError = false,
  }) {
    return RecitationLoaded(
      ayahs: ayahs ?? this.ayahs,
      currentAyahIndex: currentAyahIndex ?? this.currentAyahIndex,
      isListening: isListening ?? this.isListening,
      recognizedText: recognizedText ?? this.recognizedText,
      isFinalResult: isFinalResult ?? this.isFinalResult,
      speechError: clearSpeechError ? null : speechError ?? this.speechError,
    );
  }

  @override
  List<Object?> get props => [
    ayahs,
    currentAyahIndex,
    isListening,
    recognizedText,
    isFinalResult,
    speechError,
  ];
}
