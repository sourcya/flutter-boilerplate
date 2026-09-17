part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageViewWidget extends GetView<OnBoardingController> {
  const BuildOnboardingPageViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          context.mediaQuery.padding.top.hBox,
          OnboardingSlideToolbarWidget(onSkip: controller.onSkip),
          8.hBox,
          Obx(
            () => OnboardingSegmentProgressWidget(
              activeIndex: controller.currentIndex.value,
              segmentCount: controller.pages.length,
            ),
          ),
          16.hBox,
          Expanded(
            child: PageView(
              restorationId: 'onboarding_page_view',
              key: controller.pageKey,
              controller: controller.pageController,
              onPageChanged: controller.onPageChanged,
              children: List.generate(
                controller.pages.length,
                (index) => OnboardingSlideComponent(onboarding: controller.pages[index]),
              ),
            ),
          ),
          24.hBox,
          Obx(
            () => OnboardingSlideFooterNavWidget(
              pageIndex: controller.currentIndex.value,
              totalPages: controller.pages.length,
            ),
          ),
          context.mediaQuery.padding.bottom.hBox,
        ],
      ),
    );
  }
}
