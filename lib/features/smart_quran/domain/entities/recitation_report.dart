import 'package:equatable/equatable.dart';

enum RecitationWordStatus { correct, warning, missing }

enum RecitationGuidanceType { tajweedRule, repetitionSchedule }

class RecitationReport extends Equatable {
  final String surahName;
  final int startAyah;
  final int endAyah;
  final List<RecitationAyah> ayahs;
  final List<RecitationWordAlert> alerts;
  final List<RecitationGuidance> guidance;

  const RecitationReport({
    required this.surahName,
    required this.startAyah,
    required this.endAyah,
    required this.ayahs,
    required this.alerts,
    required this.guidance,
  });

  // Total words
  int get totalWordCount =>
      ayahs.fold(0, (total, ayah) => total + ayah.words.length);

  // Correct words
  int get correctWordCount => ayahs.fold(
    0,
    (total, ayah) =>
        total +
        ayah.words
            .where((word) => word.status == RecitationWordStatus.correct)
            .length,
  );

  // Incorrect / warning words
  int get incorrectWordCount => ayahs.fold(
    0,
    (total, ayah) =>
        total +
        ayah.words
            .where((word) => word.status == RecitationWordStatus.warning)
            .length,
  );

  // Missing words
  int get missingWordCount => ayahs.fold(
    0,
    (total, ayah) =>
        total +
        ayah.words
            .where((word) => word.status == RecitationWordStatus.missing)
            .length,
  );

  // Accuracy percentage
  int get accuracyPercentage {
    if (totalWordCount == 0) return 0;

    return ((correctWordCount / totalWordCount) * 100).round();
  }

  // Performance title
  String get resultTitle {
    if (accuracyPercentage >= 95) return 'ممتاز';
    if (accuracyPercentage >= 85) return 'جيد جداً';
    if (accuracyPercentage >= 70) return 'جيد';
    return 'يحتاج إلى مراجعة';
  }

  // Find alert by word ID
  RecitationWordAlert? alertFor(int wordId) {
    for (final alert in alerts) {
      if (alert.wordId == wordId) return alert;
    }
    return null;
  }

  // Find word by ID
  RecitationWord? wordById(int wordId) {
    for (final ayah in ayahs) {
      for (final word in ayah.words) {
        if (word.id == wordId) return word;
      }
    }
    return null;
  }

  @override
  List<Object?> get props => [
    surahName,
    startAyah,
    endAyah,
    ayahs,
    alerts,
    guidance,
  ];
}

class RecitationAyah extends Equatable {
  final int ayahNumber;
  final List<RecitationWord> words;

  const RecitationAyah({required this.ayahNumber, required this.words});

  @override
  List<Object?> get props => [ayahNumber, words];
}

class RecitationWord extends Equatable {
  final int id;
  final String text;
  final RecitationWordStatus status;

  const RecitationWord({
    required this.id,
    required this.text,
    this.status = RecitationWordStatus.correct,
  });

  @override
  List<Object?> get props => [id, text, status];
}

class RecitationWordAlert extends Equatable {
  final int wordId;
  final int ayahNumber;
  final String ruleName;
  final String correctText;
  final String? correctHint;
  final String recordedText;
  final String? correctAudioUrl;
  final String? recordedAudioUrl;

  const RecitationWordAlert({
    required this.wordId,
    required this.ayahNumber,
    required this.ruleName,
    required this.correctText,
    required this.recordedText,
    this.correctHint,
    this.correctAudioUrl,
    this.recordedAudioUrl,
  });

  @override
  List<Object?> get props => [
    wordId,
    ayahNumber,
    ruleName,
    correctText,
    correctHint,
    recordedText,
    correctAudioUrl,
    recordedAudioUrl,
  ];
}

class RecitationGuidance extends Equatable {
  final RecitationGuidanceType type;
  final String title;
  final String description;

  const RecitationGuidance({
    required this.type,
    required this.title,
    required this.description,
  });

  @override
  List<Object?> get props => [type, title, description];
}
