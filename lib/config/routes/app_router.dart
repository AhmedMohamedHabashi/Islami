import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:islami/features/onboarding/presentation/views/splash_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        // builder: (context, state) => const SplashView(),
      ),

      GoRoute(
        path: RouteNames.onboarding,
        // builder: (context, state) => const OnboardingView(),
      ),
    ],
  );
}
