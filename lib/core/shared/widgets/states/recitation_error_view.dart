import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/config/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/states/error_state_view.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/common/recitation_args.dart';
import 'package:islami/features/smart_quran/presentation/cubit/recitation/recitation_cubit.dart';

class RecitationErrorView extends StatelessWidget {
  final String message;
  final RecitationArgs args;

  const RecitationErrorView({
    super.key,
    required this.message,
    required this.args,
  });

  void _retry(BuildContext context) {
    context.read<RecitationCubit>().loadAyahs(
      surahNumber: args.selectedSurah.number,
      startAyah: args.startAyah,
      endAyah: args.endAyah,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: ErrorStateView(
          icon: Icons.menu_book_rounded,
          message: message,
          retryLabel: l10n.retry,
          onRetry: () => _retry(context),
        ),
      ),
    );
  }
}
