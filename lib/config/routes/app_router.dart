import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/di/injection_container.dart';
import 'package:islami/features/azkar/presentaion/cubit/azkar/azkar_details_cubit.dart';
import 'package:islami/features/azkar/presentaion/views/azkar_details_view.dart';
import 'package:islami/features/azkar/presentaion/views/azkar_view.dart';
import 'package:islami/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:islami/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:islami/features/onboarding/presentation/views/splash_view.dart';
import 'package:islami/features/radio/presentation/views/radio_view.dart';
import 'package:islami/features/radio/presentation/views/widgets/coming_soon_page.dart';
import 'package:islami/features/radio/presentation/views/widgets/main_layout.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation/recitation_view.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation_report/cubit/recitation_report_cubit.dart';
import 'package:islami/features/smart_quran/presentation/views/recitation_report/recitation_report_view.dart';
import 'package:islami/features/smart_quran/presentation/views/surah_selection/surah_selection_view.dart';
import 'package:islami/features/time/presentation/cubit/azkar/oazkar_cubit.dart';
import 'package:islami/features/time/presentation/cubit/prayer_times/prayer_times_cubit.dart';
import 'package:islami/features/time/presentation/views/time_view.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) {
          return BlocProvider(
            create: (_) => OnboardingCubit(),
            child: const OnboardingView(),
          );
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainLayout(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.quran,
                builder: (context, state) => const SurahSelectionView(),
                routes: [
                  GoRoute(
                    path: RouteNames.recitationView,
                    builder: (context, state) => const RecitationView(),
                  ),
                ],
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
                builder: (context, state) {
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider(
                        create: (context) =>
                            sl<PrayerTimesCubit>()..fetchPrayerTimes(),
                      ),
                      BlocProvider(
                        create: (context) =>
                            sl<AzkarCubit>()..fetchAzkarCategories(),
                      ),
                    ],
                    child: const TimeView(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: RouteNames.surahSelectionView,
        builder: (context, state) => const SurahSelectionView(),
      ),
      GoRoute(
        path: RouteNames.recitationView,
        builder: (context, state) => const RecitationView(),
      ),
      GoRoute(
        path: RouteNames.recitationReportView,
        builder: (context, state) => BlocProvider(
          create: (_) => RecitationReportCubit(),
          child: const RecitationReportView(),
        ),
      ),
      GoRoute(
        path: RouteNames.azkar,
        builder: (context, state) {
          final categoryTitle = state.extra as String? ?? '';

          return BlocProvider(
            create: (context) =>
                sl<AzkarDetailsCubit>()..fetchZkars(categoryTitle),
            child: AzkarView(categoryTitle: categoryTitle),
          );
        },
      ),
      GoRoute(
        path: RouteNames.azkardetails,
        builder: (context, state) => const AzkarDetailsView(),
      ),
    ],
  );
}
