import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/shared/widgets/radio/main_layout.dart';
import 'package:islami/features/radio/presentation/views/radio_view.dart';
import 'package:islami/features/radio/presentation/views/widgets/coming_soon_page.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.radio,
    routes: [
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
                builder: (_, _) => const ComingSoonPage(title: 'Time'),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
 // GoRoute(
      //   path: RouteNames.onboarding,
      //   // builder: (context, state) => const OnboardingView(),
      // ),