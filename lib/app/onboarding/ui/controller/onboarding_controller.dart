import 'package:flutter/cupertino.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../../core/resources/assets/assets.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../data/model/onboarding.dart';

class OnBoardingController extends GetxController {
  final pageController = PageController();

  final currentIndex = 0.obs;
  final isCompleted = false.obs;

  final _navigation = AppNavigation.instance;

  final pages = <OnBoarding>[
    OnBoarding(
      title: AppTrans.firstBoardingTitle.tr,
      subtitle: AppTrans.firstBoardingSubTitle.tr,
      lottieAsset: Assets.animations.firstBoardingAnimation,
    ),
    OnBoarding(
      title: AppTrans.secondBoardingTitle.tr,
      subtitle: AppTrans.secondBoardingSubTitle.tr,
      lottieAsset: Assets.animations.secondBoardingAnimation,
    ),
    OnBoarding(
      title: AppTrans.thirdBoardingTitle.tr,
      subtitle: AppTrans.thirdBoardingSubTitle.tr,
      lottieAsset: Assets.animations.thirdBoardingAnimation,
    ),
  ];

  Future<void> handleNextOrSkip() async {
    if (isCompleted.value) {
      MyPreferenceManger.instance.saveOnBoardingShown();

      _navigation.navigateFromOnBoardingToLogin();
    } else {
      pageController.animateToPage(currentIndex.value + 1,
          duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }


  void onPageChanged(int value) {
    currentIndex.value = value;
    isCompleted.value = value == pages.length - 1;
  }
}
