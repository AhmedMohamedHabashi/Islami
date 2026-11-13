import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import '../../../cubit/recitation_report/recitation_report_cubit.dart';
import 'recitation_alert_section.dart';
import 'recitation_guidance_section.dart';
import 'recitation_report_actions.dart';
import 'recitation_report_header.dart';
import 'recitation_status_legend.dart';
import 'recitation_words_panel.dart';

class RecitationReportContent extends StatelessWidget {
  final RecitationReportLoaded state;

  const RecitationReportContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RecitationReportCubit>();

    final alert = state.selectedAlert;
    final selectedWord = state.selectedWord;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Word-by-word analysis
        Container(
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(24.r),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.08)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const RecitationReportHeader(),

              SizedBox(height: 12.h),

              const RecitationStatusLegend(),

              SizedBox(height: 14.h),

              RecitationWordsPanel(
                ayahs: state.report.ayahs,
                selectedWordId: state.selectedWordId,
                onWordTap: cubit.selectWord,
              ),

              // Selected word alert
              if (alert != null && selectedWord != null) ...[
                SizedBox(height: 14.h),

                RecitationAlertSection(
                  word: selectedWord,
                  alert: alert,
                  playingTarget: state.playingTarget,
                  onPlayTap: cubit.togglePlayback,
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: 20.h),

        // AI guidance
        RecitationGuidanceSection(guidance: state.report.guidance),

        SizedBox(height: 20.h),

        // Report actions
        RecitationReportActions(
          onApprove: cubit.approveResult,
          onRetry: cubit.retryRecitation,
        ),
      ],
    );
  }
}
