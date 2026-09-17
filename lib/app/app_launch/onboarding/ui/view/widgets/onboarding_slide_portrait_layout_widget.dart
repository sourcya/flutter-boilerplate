part of '../../imports/onboarding_imports.dart';

class OnboardingSlidePortraitLayoutWidget extends StatelessWidget {
  final OnBoarding data;

  const OnboardingSlidePortraitLayoutWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isAppLandscape) {
      return Row(
        children: [
          Container(
            constraints: BoxConstraints(maxWidth: context.width * 0.5),
            child: OnboardingHeroSvgWidget(assetPath: data.illustrationAsset),
          ),
          32.wBox,
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16.r,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 8.r,
                    children: [
                      OnboardingHeadingRichTextWidget(
                        parts: data.titleParts,
                        textAlign: TextAlign.center,
                        fontSize: 36,
                        height: 1.11,
                        letterSpacing: -0.90,
                      ),
                      CustomText(
                        data.subtitleKey,
                        textAlign: TextAlign.center,
                        color: context.colors.mutedForeground,
                        fontSize: 16.sp,
                        height: 1.50,
                        fontWeight: FontWeight.w400,
                      ),
                    ],
                  ),
                  if (data.showWebDashboardButton)
                    Center(
                      child: ViewDashboardButton(url: data.webDashboardUrl),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: context.height * 0.5),
          child: OnboardingHeroSvgWidget(assetPath: data.illustrationAsset),
        ),
        32.hBox,
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16.r,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8.r,
                  children: [
                    OnboardingHeadingRichTextWidget(
                      parts: data.titleParts,
                      textAlign: TextAlign.center,
                      fontSize: 36,
                      height: 1.11,
                      letterSpacing: -0.90,
                    ),
                    CustomText(
                      data.subtitleKey,
                      textAlign: TextAlign.center,
                      color: context.colors.mutedForeground,
                      fontSize: 16.sp,
                      height: 1.50,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
                if (data.showWebDashboardButton)
                  Center(
                    child: ViewDashboardButton(url: data.webDashboardUrl),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
