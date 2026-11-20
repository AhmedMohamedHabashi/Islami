import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/di/injection_container.dart';
import 'package:islami/core/localization/app_error_localizer.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/shared/widgets/snackbars/custom_snack_bar.dart';
import 'package:islami/core/shared/widgets/states/error_state_view.dart';
import 'package:islami/core/shared/widgets/states/loading_state_view.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/common/recitation_args.dart';
import 'package:islami/features/smart_quran/presentation/cubit/surah_selection/smart_quran_cubit.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/surah_selection_body.dart';

class SurahSelectionView extends StatefulWidget {
  const SurahSelectionView({super.key});

  @override
  State<SurahSelectionView> createState() => _SurahSelectionViewState();
}

class _SurahSelectionViewState extends State<SurahSelectionView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<SmartQuranCubit>(),
      child: BlocBuilder<SmartQuranCubit, SmartQuranState>(
        builder: (context, state) {
          final l10n = AppLocalizations.of(context)!;

          // Loading State
          if (state is SmartQuranLoading || state is SmartQuranInitial) {
            return const Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: SafeArea(child: LoadingStateView()),
            );
          }

          // Error State
          if (state is SmartQuranError) {
            final errorMessage = AppErrorLocalizer.getMessage(
              context,
              state.message,
            );

            return Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: SafeArea(
                child: ErrorStateView(
                  icon: Icons.menu_book_rounded,
                  title: l10n.somethingWentWrongTitle,
                  message: errorMessage,
                  retryLabel: l10n.retry,
                  onRetry: () {
                    context.read<SmartQuranCubit>().loadSurahs();
                  },
                ),
              ),
            );
          }

          if (state is SmartQuranLoaded) {
            final cubit = context.read<SmartQuranCubit>();

            return Directionality(
              textDirection: l10n.localeName == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: Scaffold(
                backgroundColor: AppColors.primaryBackground,
                body: SafeArea(
                  child: SurahSelectionBody(
                    searchController: _searchController,
                    surahs: state.filteredSurahs,
                    selectedSurah: state.selectedSurah,
                    onSurahSelected: cubit.selectSurah,
                    selectedFilter: state.selectedFilter,
                    selectedMode: state.selectedMode,
                    startAyah: state.startAyah,
                    endAyah: state.endAyah,
                    onSearchChanged: cubit.searchSurahs,
                    onFilterChanged: cubit.changeFilter,
                    onStartAyahChanged: cubit.changeStartAyah,
                    onEndAyahChanged: cubit.changeEndAyah,
                    onModeChanged: cubit.changeMode,
                    onStartRecitation: () {
                      final selectedSurah = state.selectedSurah;

                      if (selectedSurah == null) {
                        CustomSnackBar.show(
                          context,
                          title: l10n.somethingWentWrongTitle,
                          message: l10n.selectSurahFirst,
                          icon: Icons.menu_book_rounded,
                        );
                        return;
                      }

                      context.push(
                        '${RouteNames.quran}${RouteNames.recitationView}',
                        extra: RecitationArgs(
                          selectedSurah: selectedSurah,
                          startAyah: state.startAyah,
                          endAyah: state.endAyah,
                          selectedMode: state.selectedMode,
                        ),
                      );
                    },
                    maxAyah: state.maxAyah ?? 15,
                  ),
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
