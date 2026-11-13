import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/di/injection_container.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/helpers/recitation_help_dialog.dart';
import 'package:islami/features/smart_quran/presentation/common/recitation_args.dart';
import 'package:islami/features/smart_quran/presentation/cubit/recitation/recitation_cubit.dart';

import 'recitation_body.dart';
import 'widgets/recording_dynamic_island.dart';

class RecitationView extends StatelessWidget {
  final RecitationArgs args;

  const RecitationView({super.key, required this.args});

  static void _onMicrophoneTap() {
    // TODO: Connect to microphone later.
  }

  static void _onListen() {
    // TODO: Connect Quran audio playback later.
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RecitationCubit>()
        ..loadAyahs(
          surahNumber: args.selectedSurah.number,
          startAyah: args.startAyah,
          endAyah: args.endAyah,
        ),
      child: BlocBuilder<RecitationCubit, RecitationState>(
        builder: (context, state) {
          if (state is RecitationInitial || state is RecitationLoading) {
            return Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                  strokeWidth: 2.w,
                ),
              ),
            );
          }

          if (state is RecitationError) {
            return Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Center(
                child: Padding(
                  padding: EdgeInsets.all(24.w),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.message,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.white),
                      ),
                      SizedBox(height: 16.h),
                      CustomActionButton(
                        title: 'إعادة المحاولة',
                        icon: Icons.refresh,
                        onPressed: () {
                          context.read<RecitationCubit>().loadAyahs(
                            surahNumber: args.selectedSurah.number,
                            startAyah: args.startAyah,
                            endAyah: args.endAyah,
                          );
                        },
                        isPrimary: true,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (state is RecitationLoaded) {
            final firstAyah = state.ayahs.first;

            final showBasmala =
                args.selectedSurah.number != 1 &&
                args.selectedSurah.number != 9 &&
                firstAyah.numberInSurah == 1;

            return Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Stack(
                children: [
                  SafeArea(
                    child: RecitationBody(
                      surahName: args.selectedSurah.name,
                      ayahInfo: 'الآيات ${args.startAyah} - ${args.endAyah}',
                      ayahs: state.ayahs,
                      highlightedWord: null,
                      showBasmala: showBasmala,
                      onBack: () => context.pop(),
                      onHelp: () => RecitationHelpDialog.show(context),
                      onMicrophoneTap: _onMicrophoneTap,
                      onListen: _onListen,
                      onFinish: () {
                        context.push(RouteNames.recitationReportView);
                      },
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 2,
                    left: 0,
                    right: 0,
                    child: const Center(child: RecordingDynamicIsland()),
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
