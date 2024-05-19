part of '../imports/onboarding_imports.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: SafeArea(
        child: OptimizedScrollView(
          child: Column(
            children: [
              const BuildOnboardingPageViewWidget(),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
