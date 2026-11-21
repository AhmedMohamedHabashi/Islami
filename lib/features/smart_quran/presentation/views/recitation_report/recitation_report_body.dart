import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/config/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/shared/widgets/app_bar/custom_app_bar.dart';
import 'package:islami/core/shared/widgets/dialogs/custom_info_dialog.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'package:islami/core/utils/app_sizes.dart';
import '../../cubit/recitation_report/recitation_report_cubit.dart';
import 'widgets/recitation_report_content.dart';
import 'widgets/report_summary_card.dart';

class RecitationReportBody extends StatelessWidget {
  const RecitationReportBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: BlocBuilder<RecitationReportCubit, RecitationReportState>(
          builder: (context, state) {
            // Loading
            if (state is RecitationReportInitial ||
                state is RecitationReportLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }

            // Error
            if (state is RecitationReportError) {
              return _buildError(context, state);
            }

            // Loaded
            if (state is! RecitationReportLoaded) {
              return const SizedBox.shrink();
            }

            final report = state.report;

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.size16W),
              child: Column(
                children: [
                  CustomAppBar(
                    title: AppLocalizations.of(context)!.recitationReportTitle,
                    subtitle:
                        '${report.surahName} • الآيات '
                        '(${report.startAyah} - ${report.endAyah})',
                    onHelp: () => _showReportHelp(context),
                  ),

                  SizedBox(height: AppSizes.size16H),

                  // Main report content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: AppSizes.size24H),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Summary card
                          ReportSummaryCard(report: report),

                          SizedBox(height: AppSizes.size20H),

                          // Word analysis + alerts + guidance + actions
                          RecitationReportContent(state: state),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // Error
  Widget _buildError(BuildContext context, RecitationReportError state) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.size24W),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.primary,
              size: AppSizes.icon42,
            ),
            SizedBox(height: AppSizes.size12H),

            Text(
              state.message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(color: AppColors.white),
            ),
            SizedBox(height: AppSizes.size16H),

            CustomActionButton(
              title: AppLocalizations.of(context)!.retry,
              icon: Icons.refresh_rounded,
              isPrimary: true,
              onPressed: () {
                context.read<RecitationReportCubit>().loadReport();
              },
            ),
          ],
        ),
      ),
    );
  }

  // Report help dialog
  void _showReportHelp(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return CustomInfoDialog(
          title: l10n.recitationReportHelpTitle,
          message: l10n.recitationReportHelpMessage,
        );
      },
    );
  }
}
