part of '../imports/onboarding_imports.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      includeAppBar: false,
      useSafeArea: false,
      backgroundColor: context.colors.authPageBackground,
      // attachPortraitConstraint: context.isAppPortrait,
      bodyAlignment: Alignment.topCenter,
      child: const BuildOnboardingPageViewWidget(),
    );
  }
}
