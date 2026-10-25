import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/features/radio/presentation/cubit/radio_cubit.dart';
import 'package:islami/features/radio/presentation/cubit/radio_state.dart';
import 'package:islami/features/radio/presentation/views/widgets/radio_body.dart';

class RadioView extends StatelessWidget {
  const RadioView({
    super.key,
    this.selectedTabIndex = 0,
    this.selectedNavigationIndex = 3,
    this.playingItemTitle,
    this.mutedItemTitles = const {},
    this.onTabChanged,
    this.onItemTap,
    this.onPlayPressed,
    this.onMutePressed,
    this.onNavigationItemSelected,
  });

  final int selectedTabIndex;
  final int selectedNavigationIndex;
  final String? playingItemTitle;
  final Set<String> mutedItemTitles;
  final ValueChanged<int>? onTabChanged;
  final ValueChanged<String>? onItemTap;
  final ValueChanged<String>? onPlayPressed;
  final ValueChanged<String>? onMutePressed;
  final ValueChanged<int>? onNavigationItemSelected;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RadioCubit(),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAssets.radioBackground),
              fit: BoxFit.cover,
            ),
          ),
          child: BlocBuilder<RadioCubit, RadioState>(
            builder: (context, state) {
              final cubit = context.read<RadioCubit>();
              return RadioBody(
                selectedTabIndex: state.selectedTabIndex,
                playingItemTitle: state.playingItemTitle,
                mutedItemTitles: state.mutedItemTitles,
                onTabChanged: cubit.changeTab,
                onItemTap: onItemTap,
                onPlayPressed: cubit.togglePlay,
                onMutePressed: cubit.toggleMute,
              );
            },
          ),
        ),
      ),
    );
  }
}
