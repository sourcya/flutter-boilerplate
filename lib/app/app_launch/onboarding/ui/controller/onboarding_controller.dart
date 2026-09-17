part of '../imports/onboarding_imports.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();
  final GlobalKey pageKey = GlobalKey();

  final currentIndex = 0.obs;
  final isCompleted = false.obs;

  final pages = onboardingPages;

  Future<void> onNextOrSkip() async {
    if (isCompleted.value) {
      await MyPreferenceManger.instance.saveOnBoardingShown();
      AppNavigation.navigateFromOnBoardingToLogin();
    } else {
      await pageController.animateToPage(
        currentIndex.value + 1,
        duration: ResponsiveConfig.animationDuration,
        curve: ResponsiveConfig.animationCurve,
      );
    }
  }

  void onPrevious() {
    final idx = pageController.hasClients ? pageController.page!.round() : currentIndex.value;
    if (idx <= 0) return;
    pageController.animateToPage(
      idx - 1,
      duration: ResponsiveConfig.animationDuration,
      curve: ResponsiveConfig.animationCurve,
    );
  }

  void onSkip() {
    MyPreferenceManger.instance.saveOnBoardingShown();
    AppNavigation.navigateFromOnBoardingToLogin();
  }

  void onPageChanged(int value) {
    currentIndex.value = value;
    isCompleted.value = value == pages.length - 1;
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
