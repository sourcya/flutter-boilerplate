part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageIndicatorsWidget
    extends GetView<OnBoardingController> {
  const BuildOnboardingPageIndicatorsWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DotsIndicator(
        dotsCount: controller.pages.length,
        position: controller.currentIndex.value,
        decorator: DotsDecorator(
          activeSize: Size(24.0.w, 12.0.h),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.r),
          ),
        ),
      );
    });
  }
}
