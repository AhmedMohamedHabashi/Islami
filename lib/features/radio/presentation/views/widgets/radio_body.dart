import 'package:flutter/material.dart';
import 'package:islami/core/constants/app_assets.dart';
import 'package:islami/features/Radio/presentation/views/widgets/radio_header.dart';
import 'package:islami/features/Radio/presentation/views/widgets/radio_item_card.dart';
import 'package:islami/features/Radio/presentation/views/widgets/radio_tab_bar.dart';

class RadioBody extends StatelessWidget {
  const RadioBody({
    super.key,
    required this.selectedTabIndex,
    required this.playingItemTitle,
    required this.mutedItemTitles,
    this.onTabChanged,
    this.onItemTap,
    this.onPlayPressed,
    this.onMutePressed,
  });

  final int selectedTabIndex;
  final String? playingItemTitle;
  final Set<String> mutedItemTitles;
  final ValueChanged<int>? onTabChanged;
  final ValueChanged<String>? onItemTap;
  final ValueChanged<String>? onPlayPressed;
  final ValueChanged<String>? onMutePressed;

  static const _radioItems = [
    'Radio Ibrahim Al-Akdar',
    'Radio Al-Qaria Yassen',
    'Radio Ahmed Al-trabulsi',
    'Radio Addokali Mohammad Alalim',
    'Radio Mahmoud Khalil Al-Husary',
  ];

  static const _reciterItems = [
    'Ibrahim Al-Akdar',
    'Akram Alalaqmi',
    'Majed Al-Enezi',
    'Malik shaibat Alhamed',
    'Maher Al-Muaiqly',
  ];

  @override
  Widget build(BuildContext context) {
    final items = selectedTabIndex == 1 ? _reciterItems : _radioItems;

    return Stack(
      fit: StackFit.expand,
      children: [
        Opacity(
          opacity: 0.12,
          child: Image.asset(AppAssets.splashBackground, fit: BoxFit.cover),
        ),
        SafeArea(
          child: Column(
            children: [
              const RadioHeader(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: RadioTabBar(
                  selectedIndex: selectedTabIndex,
                  onTabChanged: onTabChanged,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    final title = items[index];
                    final isActive = selectedTabIndex == 0 && index == 1;

                    return RadioItemCard(
                      title: title,
                      isPlaying: isActive,
                      isMuted: isActive,
                      showWaveform: isActive,
                      onTap: () => onItemTap?.call(title),
                      onPlayPressed: () => onPlayPressed?.call(title),
                      onMutePressed: () => onMutePressed?.call(title),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
