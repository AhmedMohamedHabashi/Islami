import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/features/radio/presentation/views/radio_view.dart';
// import 'package:islami/features/smart_quran/presentation/views/surah_selection/surah_selection_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.radio,
    routes: [
      GoRoute(
        path: RouteNames.radio,
        builder: (context, state) => const RadioView(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) =>
            const Scaffold(body: Center(child: Text('Onboarding screen'))),
      ),
    ],
  );
}
