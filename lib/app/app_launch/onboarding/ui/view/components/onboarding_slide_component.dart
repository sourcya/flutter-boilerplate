part of '../../imports/onboarding_imports.dart';

class OnboardingSlideComponent extends StatelessWidget {
  final OnBoarding onboarding;

  const OnboardingSlideComponent({
    super.key,
    required this.onboarding,
  });

  @override
  Widget build(BuildContext context) {
    return OnboardingSlidePortraitLayoutWidget(
      data: onboarding,
    );
  }
}
