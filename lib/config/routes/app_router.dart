import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/features/radio/presentation/views/radio_view.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/surah_selection_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.surahSelectionView,
    routes: [
      GoRoute(
        path: RouteNames.surahSelectionView,
        builder: (context, state) => const SurahSelectionView(),
      ),

      // GoRoute(
      //   path: RouteNames.onboarding,
      //   // builder: (context, state) => const OnboardingView(),
      // ),
    ],
  );
}
