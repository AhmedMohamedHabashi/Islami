import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/di/injection_container.dart';
import 'package:islami/core/shared/widgets/bouttons/custom_action_button.dart';
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
          if (state is SmartQuranLoading || state is SmartQuranInitial) {
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

          if (state is SmartQuranError) {
            return Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Center(
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
                      icon: Icons.refresh_rounded,
                      onPressed: () {
                        context.read<SmartQuranCubit>().loadSurahs();
                      },
                      isPrimary: true,
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is SmartQuranLoaded) {
            final cubit = context.read<SmartQuranCubit>();

            return Directionality(
              textDirection: TextDirection.rtl,
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('من فضلك اختر السورة أولاً'),
                          ),
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
