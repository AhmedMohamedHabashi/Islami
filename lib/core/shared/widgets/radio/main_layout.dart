import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/core/shared/widgets/radio/custom_radio_bottom.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomRadioBottom(
        selectedIndex: navigationShell.currentIndex,
        onItemSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
      ),
    );
  }
}
