part of '../../imports/login_imports.dart';

class LoginOnboardingPanel extends GetView<OnboardingSlidesCarouselController> {
  const LoginOnboardingPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return OptimizedScrollView(
      child: Obx(
        () => OnboardingSlidesWidget(
          slides: onboardingPages,
          activeIndex: controller.currentPage.value,
          trailingContent: const LoginPanelQrCodesSectionWidget(),
        ),
      ),
    );
  }
}
