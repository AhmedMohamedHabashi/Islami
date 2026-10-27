import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/shared/widgets/radio/main_layout.dart';
import 'package:islami/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:islami/features/onboarding/presentation/views/splash_view.dart';
import 'package:islami/features/radio/presentation/views/radio_view.dart';
import 'package:islami/features/radio/presentation/views/widgets/coming_soon_page.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/surah_selection_view.dart';
import 'package:islami/features/time/presentation/views/time_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.time,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainLayout(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.quran,
                builder: (_, _) => const ComingSoonPage(title: 'Quran'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.hadith,
                builder: (_, _) => const ComingSoonPage(title: 'Hadith'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.tasbih,
                builder: (_, _) => const ComingSoonPage(title: 'Tasbih'),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.radio,
                builder: (_, _) => const RadioView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.time,
                builder: (_, _) => const TimeView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.surahSelectionView,
        builder: (context, state) => const SurahSelectionView(),
      ),
    ],
  );
}