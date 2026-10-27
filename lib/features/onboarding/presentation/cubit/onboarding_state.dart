part of 'onboarding_cubit.dart';

sealed class OnboardingState extends Equatable {
  const OnboardingState();

  @override
  List<Object> get props => [];
}

final class OnboardingInitial extends OnboardingState {
  const OnboardingInitial();
}

final class OnboardingPageChanged extends OnboardingState {
  final int currentIndex;

  const OnboardingPageChanged(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
