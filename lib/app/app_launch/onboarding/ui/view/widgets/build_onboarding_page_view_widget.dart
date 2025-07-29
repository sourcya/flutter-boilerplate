part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageViewWidget extends GetView<OnBoardingController> {
  const BuildOnboardingPageViewWidget();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller.pageController,
      onPageChanged: controller.onPageChanged,
      children: List.generate(
        controller.pages.length,
        (index) => OnBoardingPage(onboarding: controller.pages[index]),
      ),
    );
  }
}
