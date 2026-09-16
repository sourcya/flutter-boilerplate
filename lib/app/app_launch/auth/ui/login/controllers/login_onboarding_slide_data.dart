part of '../imports/login_imports.dart';

class LoginOnboardingSlideData {
  final String titleKey;
  final String subtitleKey;
  final String onboardingAsset;
  final LoginOnboardingAppLinks? appLinks;

  const LoginOnboardingSlideData({
    required this.titleKey,
    required this.subtitleKey,
    required this.onboardingAsset,
    this.appLinks,
  });
}

class LoginOnboardingAppLinks {
  final String iosStoreUrl;
  final String playStoreUrl;

  const LoginOnboardingAppLinks({
    required this.iosStoreUrl,
    required this.playStoreUrl,
  });
}

final List<LoginOnboardingSlideData> loginOnboardingSlides = [
  LoginOnboardingSlideData(
    titleKey: AppTrans.firstBoardingTitle,
    subtitleKey: AppTrans.firstBoardingSubTitle,
    onboardingAsset: Assets.animations.firstBoardingAnimation,
    appLinks: const LoginOnboardingAppLinks(
      iosStoreUrl: Constants.iosStoreUrl,
      playStoreUrl: Constants.playStoreUrl,
    ),
  ),
  LoginOnboardingSlideData(
    titleKey: AppTrans.secondBoardingTitle,
    subtitleKey: AppTrans.secondBoardingSubTitle,
    onboardingAsset: Assets.animations.secondBoardingAnimation,
    appLinks: const LoginOnboardingAppLinks(
      iosStoreUrl: Constants.iosStoreUrl,
      playStoreUrl: Constants.playStoreUrl,
    ),
  ),
  LoginOnboardingSlideData(
    titleKey: AppTrans.thirdBoardingTitle,
    subtitleKey: AppTrans.thirdBoardingSubTitle,
    onboardingAsset: Assets.animations.thirdBoardingAnimation,
    appLinks: const LoginOnboardingAppLinks(
      iosStoreUrl: Constants.iosStoreUrl,
      playStoreUrl: Constants.playStoreUrl,
    ),
  ),
];
