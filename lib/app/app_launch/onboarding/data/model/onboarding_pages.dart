part of '../../ui/imports/onboarding_imports.dart';

/// Single source of truth for onboarding slide content (mobile flow + login panel).
final List<OnBoarding> onboardingPages = [
  OnBoarding(
    titleParts: const OnboardingTitleParts(
      accentKey: AppTrans.firstBoardingTitleAccent,
      trailingKey: AppTrans.firstBoardingTitleTrailing,
    ),
    subtitleKey: AppTrans.firstBoardingSubTitle,
    illustrationAsset: Assets.animations.firstBoardingAnimation,
    showWebDashboardButton: true,
    webDashboardUrl: Constants.webUrl,
    appLinks: const OnboardingAppLinks(
      playStoreUrl: Constants.playStoreUrl,
      iosStoreUrl: Constants.iosStoreUrl,
    ),
  ),
  OnBoarding(
    titleParts: const OnboardingTitleParts(
      accentKey: AppTrans.secondBoardingTitleAccent,
      trailingKey: AppTrans.secondBoardingTitleTrailing,
    ),
    subtitleKey: AppTrans.secondBoardingSubTitle,
    illustrationAsset: Assets.animations.secondBoardingAnimation,
    appLinks: const OnboardingAppLinks(
      playStoreUrl: Constants.playStoreUrl,
      iosStoreUrl: Constants.iosStoreUrl,
    ),
  ),
  OnBoarding(
    titleParts: const OnboardingTitleParts(
      accentKey: AppTrans.thirdBoardingTitleAccent,
      trailingKey: AppTrans.thirdBoardingTitleTrailing,
    ),
    subtitleKey: AppTrans.thirdBoardingSubTitle,
    illustrationAsset: Assets.animations.thirdBoardingAnimation,
    appLinks: const OnboardingAppLinks(
      playStoreUrl: Constants.playStoreUrl,
      iosStoreUrl: Constants.iosStoreUrl,
    ),
  ),
];
