import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/features/radio/presentation/views/widgets/radio_body.dart';
import 'package:islami/core/shared/widgets/radio/custom_radio_bottom.dart';

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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.radioBackground),
            fit: BoxFit.cover,
          ),
        ),
        child: RadioBody(
          selectedTabIndex: selectedTabIndex,
          playingItemTitle: playingItemTitle,
          mutedItemTitles: mutedItemTitles,
          onTabChanged: onTabChanged,
          onItemTap: onItemTap,
          onPlayPressed: onPlayPressed,
          onMutePressed: onMutePressed,
        ),
      ),
      bottomNavigationBar: CustomRadioBottom(
        selectedIndex: selectedNavigationIndex,
        onItemSelected: onNavigationItemSelected,
      ),
    );
  }
}
