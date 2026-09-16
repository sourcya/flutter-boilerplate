part of '../../imports/onboarding_imports.dart';

/// Reusable onboarding slides presentation for panel layouts (e.g. login wide screen).
class OnboardingSlidesWidget extends StatelessWidget {
  final List<OnBoarding> slides;
  final int activeIndex;
  final Widget? trailingContent;

  const OnboardingSlidesWidget({
    super.key,
    required this.slides,
    required this.activeIndex,
    this.trailingContent,
  });

  OnBoarding get _slide => slides[activeIndex.clamp(0, slides.length - 1)];

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 80.0.r,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 16.0.r,
          children: [
            OnboardingSegmentProgressWidget(
              activeIndex: activeIndex,
              segmentCount: slides.length,
            ),
            SizedBox(
              height: 480.r,
              child: Padding(
                padding: context.paddingSymmetric(horizontal: 24, vertical: 16),
                child: Center(
                  child: OnboardingHeroSvgWidget(
                    assetPath: _slide.illustrationAsset,
                    height: 440.0.r,
                    animateChanges: true,
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 36.0.r,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnboardingHeadingRichTextWidget(
                    parts: _slide.titleParts,
                    fontSize: 36,
                    height: 1.11,
                    letterSpacing: -0.90,
                  ),
                  8.hBox,
                  CustomText(
                    _slide.subtitleKey,
                    textStyle: context.bodyLargeTS.copyWith(
                      color: context.colors.mutedForeground,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                    ),
                  ),
                ],
              ),
            ),
            if (trailingContent != null) trailingContent!,
          ],
        ),
      ],
    );
  }
}
