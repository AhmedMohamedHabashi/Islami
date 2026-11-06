import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/smart_quran/presentation/cubit/smart_quran_cubit.dart';
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

  void _startRecitation() {
    context.go('${RouteNames.quran}/recitation');
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SmartQuranCubit(),
      child: BlocBuilder<SmartQuranCubit, SmartQuranState>(
        builder: (context, state) {
          if (state is! SmartQuranLoaded) {
            return const Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: Center(child: CircularProgressIndicator()),
            );
          }

          final cubit = context.read<SmartQuranCubit>();

          return Directionality(
            textDirection: TextDirection.rtl,
            child: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              body: SafeArea(
                child: SurahSelectionBody(
                  searchController: _searchController,
                  surahs: state.filteredSurahs,
                  selectedFilter: state.selectedFilter,
                  selectedMode: state.selectedMode,
                  startAyah: state.startAyah,
                  endAyah: state.endAyah,
                  onSearchChanged: cubit.searchSurahs,
                  onFilterChanged: cubit.changeFilter,
                  onStartAyahChanged: cubit.changeStartAyah,
                  onEndAyahChanged: cubit.changeEndAyah,
                  onModeChanged: cubit.changeMode,
                  onStartRecitation: _startRecitation,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
