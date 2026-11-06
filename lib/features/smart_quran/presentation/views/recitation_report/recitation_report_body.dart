import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/shared/widgets/header/custom_app_bar.dart';
import 'package:islami/core/shared/widgets/dialogs/custom_info_dialog.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/themes/text_style/app_text_styles.dart';
import 'cubit/recitation_report_cubit.dart';
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
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                children: [
                  CustomAppBar(
                    title: AppLocalizations.of(context)!.recitationReportTitle,
                    subtitle:
                        '${report.surahName} • الآيات '
                        '(${report.startAyah} - ${report.endAyah})',
                    onHelp: () => _showReportHelp(context),
                  ),

                  SizedBox(height: 12.h),

                  // Main report content
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.only(bottom: 24.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Summary card
                          ReportSummaryCard(report: report),

                          SizedBox(height: 20.h),

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
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: AppColors.primary,
              size: 42.sp,
            ),
            SizedBox(height: 12.h),

            Text(
              state.message,
              textAlign: TextAlign.center,
              style: AppTextStyles.body14.copyWith(color: AppColors.white),
            ),
            SizedBox(height: 16.h),

            CustomActionButton(
              title: 'إعادة المحاولة',
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
