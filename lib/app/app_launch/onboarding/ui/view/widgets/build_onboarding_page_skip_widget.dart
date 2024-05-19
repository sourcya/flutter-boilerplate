part of '../../imports/onboarding_imports.dart';

class BuildOnboardingPageSkipWidget extends GetView<OnBoardingController> {
  const BuildOnboardingPageSkipWidget();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return CustomElevatedButton(
        width: context.width * .35,
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 24.w),
        onPressed: controller.handleNextOrSkip,
        label: controller.isCompleted.value ? AppTrans.skip : AppTrans.next,
      );
    });
  }
}
