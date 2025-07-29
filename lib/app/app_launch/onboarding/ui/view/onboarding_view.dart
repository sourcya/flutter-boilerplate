part of '../imports/onboarding_imports.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: context.colors.surface,
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(child: BuildOnboardingPageViewWidget()),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 8.w),
              child: const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BuildOnboardingPageIndicatorsWidget(),
                    Spacer(),
                    BuildOnboardingPageSkipWidget(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
