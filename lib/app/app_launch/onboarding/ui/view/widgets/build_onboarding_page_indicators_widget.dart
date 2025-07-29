part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageIndicatorsWidget
    extends GetView<OnBoardingController> {
  const BuildOnboardingPageIndicatorsWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DotsIndicator(
        dotsCount: controller.pages.length,
        position: controller.currentIndex.value.toDouble(),
        decorator: DotsDecorator(
          activeSize: Size(24.0.r, 12.0.h),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0.r),
          ),
          activeColor: context.colors.primary,
        ),
      );
    });
  }
}
