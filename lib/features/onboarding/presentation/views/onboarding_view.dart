import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:islami/config/routes/route_names.dart';
import 'package:islami/core/localization/l10n/app_localizations.dart';
import 'package:islami/core/themes/colors/app_colors.dart';
import 'package:islami/features/onboarding/data/models/onboarding_data.dart';
import 'package:islami/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:islami/features/onboarding/presentation/views/widgets/onboarding_body.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void nextPage() {
    final pages = OnboardingData.getPages(AppLocalizations.of(context)!);

    final currentIndex =
        context.read<OnboardingCubit>().state is OnboardingPageChanged
        ? (context.read<OnboardingCubit>().state as OnboardingPageChanged)
              .currentIndex
        : 0;

    if (currentIndex < pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(RouteNames.quran);
    }
  }

  void backPage() {
    final state = context.read<OnboardingCubit>().state;
    final currentIndex = state is OnboardingPageChanged
        ? state.currentIndex
        : 0;

    if (currentIndex > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = OnboardingData.getPages(AppLocalizations.of(context)!);

    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: SafeArea(
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            final currentIndex = state is OnboardingPageChanged
                ? state.currentIndex
                : 0;

            return OnboardingBody(
              animation: _fadeAnimation,
              slideAnimation: _slideAnimation,
              currentIndex: currentIndex,
              pages: pages,
              pageController: _pageController,
              onPageChanged: (index) {
                context.read<OnboardingCubit>().changePage(index);
              },
              onBack: backPage,
              onNext: nextPage,
            );
          },
        ),
      ),
    );
  }
}
