part of '../../imports/onboarding_imports.dart';


class BuildOnboardingPageSkipWidget extends GetView<OnBoardingController> {

  const BuildOnboardingPageSkipWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(8.0.r),
      child: SizedBox(
        width: context.width * .3,
        child: ElevatedButton(
          onPressed: controller.handleNextOrSkip,
          style: ElevatedButton.styleFrom(
            // backgroundColor: colorScheme.primary,
            padding:  EdgeInsets.symmetric(
              vertical: 12.h,
              horizontal: 8.w,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Obx(() {
            return Text(
              controller.isCompleted.value
                  ? AppTrans.skip.tr
                  : AppTrans.next.tr,
              style:  TextStyle(fontSize: 18.sp),
            );
          }),
        ),
      ),
    );
  }
}
