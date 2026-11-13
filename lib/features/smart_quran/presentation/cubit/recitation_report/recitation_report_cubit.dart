import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/mock/recitation_report_mock.dart';
import '../../../domain/entities/recitation_report.dart';

part 'recitation_report_state.dart';

class RecitationReportCubit extends Cubit<RecitationReportState> {
  RecitationReportCubit() : super(const RecitationReportInitial()) {
    loadReport();
  }

  // Load report
  Future<void> loadReport() async {
    emit(const RecitationReportLoading());

    try {
      // TODO(logic): Replace mock with GetRecitationReportUseCase.
      const report = mockRecitationReport;

      emit(
        RecitationReportLoaded(
          report: report,
          selectedWordId: report.alerts.isEmpty
              ? null
              : report.alerts.first.wordId,
        ),
      );
    } catch (_) {
      emit(const RecitationReportError('حدث خطأ أثناء تحميل تقرير التسميع'));
    }
  }

  // Select word
  void selectWord(int wordId) {
    final current = state;

    if (current is! RecitationReportLoaded) return;

    if (current.selectedWordId == wordId) return;

    emit(current.withSelectedWord(wordId));

    // TODO(logic): Play selected word audio.
  }

  // Toggle audio playback
  void togglePlayback(RecitationAudioTarget target) {
    final current = state;

    if (current is! RecitationReportLoaded) return;

    emit(
      current.withPlayingTarget(
        current.playingTarget == target ? null : target,
      ),
    );

    // TODO(logic): Connect audio player.
  }

  // Approve result
  void approveResult() {
    // TODO(logic): Save surah to memorized list.
  }

  // Retry recitation
  void retryRecitation() {
    // TODO(logic): Navigate to recitation screen.
  }
}
