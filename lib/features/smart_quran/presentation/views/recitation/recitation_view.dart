import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/core/utils/helpers/recitation_help_dialog.dart';
import 'recitation_body.dart';
import 'widgets/recording_dynamic_island.dart';

class RecitationView extends StatelessWidget {
  const RecitationView({super.key});

  static void _onMicrophoneTap() {
    // TODO: Connect to RecitationCubit later.
  }
  static void _onListen() {
    // TODO: Connect Quran audio playback later.
  }

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Stack(
        children: [
          // Main recitation content.
          SafeArea(
            child: RecitationBody(
              onHelp: () => RecitationHelpDialog.show(context),
              onMicrophoneTap: _onMicrophoneTap,
              onListen: _onListen,
              onFinish: () {
                context.push(RouteNames.recitationReportView);
              },
            ),
          ),

          Positioned(
            top: topInset + 2,
            left: 0,
            right: 0,
            child: const Center(child: RecordingDynamicIsland()),
          ),
        ],
      ),
    );
  }
}
