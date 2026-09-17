/// Title segments for onboarding headlines (Figma: accent vs foreground spans).
class OnboardingTitleParts {
  final String? prefixKey;
  final String accentKey;
  final String? trailingKey;

  const OnboardingTitleParts({
    this.prefixKey,
    required this.accentKey,
    this.trailingKey,
  });
}

class OnboardingAppLinks {
  final String? playStoreUrl;
  final String? iosStoreUrl;

  const OnboardingAppLinks({
    this.playStoreUrl,
    this.iosStoreUrl,
  });

  bool get hasLinks => (playStoreUrl?.isNotEmpty ?? false) || (iosStoreUrl?.isNotEmpty ?? false);
}

class OnBoarding {
  final OnboardingTitleParts titleParts;
  final String subtitleKey;
  final String illustrationAsset;
  final bool showWebDashboardButton;
  final String? webDashboardUrl;
  final OnboardingAppLinks? appLinks;

  const OnBoarding({
    required this.titleParts,
    required this.subtitleKey,
    required this.illustrationAsset,
    this.showWebDashboardButton = false,
    this.webDashboardUrl,
    this.appLinks,
  });
}
