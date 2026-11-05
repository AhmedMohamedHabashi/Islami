part of 'recitation_report_cubit.dart';

enum RecitationAudioTarget { correct, recorded }

sealed class RecitationReportState extends Equatable {
  const RecitationReportState();

  @override
  List<Object?> get props => [];
}

final class RecitationReportInitial extends RecitationReportState {
  const RecitationReportInitial();
}

final class RecitationReportLoading extends RecitationReportState {
  const RecitationReportLoading();
}

final class RecitationReportLoaded extends RecitationReportState {
  final RecitationReport report;
  final int? selectedWordId;
  final RecitationAudioTarget? playingTarget;

  const RecitationReportLoaded({
    required this.report,
    this.selectedWordId,
    this.playingTarget,
  });

  RecitationWordAlert? get selectedAlert {
    if (selectedWordId == null) return null;
    return report.alertFor(selectedWordId!);
  }

  RecitationWord? get selectedWord {
    if (selectedWordId == null) return null;
    return report.wordById(selectedWordId!);
  }

  RecitationReportLoaded withSelectedWord(int? wordId) {
    return RecitationReportLoaded(
      report: report,
      selectedWordId: wordId,
      playingTarget: null,
    );
  }

  RecitationReportLoaded withPlayingTarget(RecitationAudioTarget? target) {
    return RecitationReportLoaded(
      report: report,
      selectedWordId: selectedWordId,
      playingTarget: target,
    );
  }

  @override
  List<Object?> get props => [report, selectedWordId, playingTarget];
}

final class RecitationReportError extends RecitationReportState {
  final String message;

  const RecitationReportError(this.message);

  @override
  List<Object?> get props => [message];
}
