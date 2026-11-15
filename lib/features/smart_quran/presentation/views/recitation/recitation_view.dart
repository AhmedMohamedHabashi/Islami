import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/di/injection_container.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/helpers/recitation_help_dialog.dart';
import 'package:islami/features/smart_quran/presentation/common/recitation_args.dart';
import 'package:islami/features/smart_quran/presentation/cubit/recitation/recitation_cubit.dart';
import 'recitation_body.dart';
import 'states/recitation_error_view.dart';
import 'states/recitation_loading_view.dart';
import 'widgets/recording_dynamic_island.dart';

class RecitationView extends StatelessWidget {
  final RecitationArgs args;

  const RecitationView({super.key, required this.args});

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
            return const RecitationLoadingView();
          }

          if (state is RecitationError) {
            return RecitationErrorView(message: state.message, args: args);
          }

          if (state is RecitationLoaded) {
            if (state.ayahs.isEmpty) {
              return RecitationErrorView(
                message: 'لم يتم العثور على آيات في النطاق المحدد.',
                args: args,
              );
            }

            final firstAyah = state.ayahs.first;
            final showBasmala =
                args.selectedSurah.number != 1 &&
                args.selectedSurah.number != 9 &&
                firstAyah.numberInSurah == 1;

            final cubit = context.read<RecitationCubit>();

            final statusText =
                state.speechError ??
                (state.isListening
                    ? 'جاري الاستماع...'
                    : 'استعد للتسميع عند الضغط على الميكروفون');

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

                      // Speech recognition state.
                      isRecording: state.isListening,
                      statusText: statusText,

                      onBack: () => context.pop(),
                      onHelp: () => RecitationHelpDialog.show(context),

                      onMicrophoneTap: () {
                        if (state.isListening) {
                          cubit.stopListening();
                        } else {
                          cubit.startListening();
                        }
                      },

                      onListen: _onListen,

                      onFinish: () async {
                        await cubit.stopListening();

                        if (!context.mounted) return;

                        context.push(RouteNames.recitationReportView);
                      },
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).padding.top + 2,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: RecordingDynamicIsland(
                        isRecording: state.isListening,
                      ),
                    ),
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
