part of '../imports/onboarding_imports.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();

  final currentIndex = 0.obs;
  final isCompleted = false.obs;

  final pages = <OnBoarding>[
    OnBoarding(
      title: AppTrans.firstBoardingTitle,
      subtitle: AppTrans.firstBoardingSubTitle,
      lottieAsset: Assets.animations.firstBoardingAnimation,
    ),
    OnBoarding(
      title: AppTrans.secondBoardingTitle,
      subtitle: AppTrans.secondBoardingSubTitle,
      lottieAsset: Assets.animations.secondBoardingAnimation,
    ),
    OnBoarding(
      title: AppTrans.thirdBoardingTitle,
      subtitle: AppTrans.thirdBoardingSubTitle,
      lottieAsset: Assets.animations.thirdBoardingAnimation,
    ),
  ];

  Future<void> handleNextOrSkip() async {
    if (isCompleted.value) {
      MyPreferenceManger.instance.saveOnBoardingShown();

      AppNavigation.navigateFromOnBoardingToLogin();
    } else {
      pageController.animateToPage(
        currentIndex.value + 1,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void onPageChanged(int value) {
    currentIndex.value = value;
    isCompleted.value = value == pages.length - 1;
  }
}
