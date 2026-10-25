
class OnboardingModel {
  final String image;
  final String title;
  final String description;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}

const List<OnboardingModel> onboardingList = [
  OnboardingModel(
    image: 'assets/images/welcome.png',
    title: 'Welcome To Islmi App',
    description: '',
  ),
  OnboardingModel(
    image: 'assets/images/kabba.png',
    title: 'Welcome To Islami',
    description: 'We Are Very Excited To Have You In Our Community',
  ),
  OnboardingModel(
    image: 'assets/images/moushaf.png',
    title: 'Reading the Quran',
    description: 'Read, and your Lord is the Most Generous',
  ),
  OnboardingModel(
    image: 'assets/images/doaa.png',
    title: 'Bearish',
    description: 'Praise the name of your Lord, the Most High',
  ),
  OnboardingModel(
    image: 'assets/images/maic.png',
    title: 'Holy Quran Radio',
    description:
        'You can listen to the Holy Quran Radio through the application for free and easily',
  ),
];