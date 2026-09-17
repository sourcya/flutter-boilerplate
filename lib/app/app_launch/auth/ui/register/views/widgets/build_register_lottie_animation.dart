part of '../../imports/register_imports.dart';

class BuildRegisterLottieAnimation extends GetView<RegisterController> {
  const BuildRegisterLottieAnimation();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(vertical: 4.0),
      child: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: controller.currentLoginMethod.value == LoginMethod.email
                ? context.paddingOnly(top: 16.0, bottom: 8, end: 8.0, start: 8)
                : context.paddingOnly(top: 60.0, bottom: 8, end: 8.0, start: 8),
            child: CircleAvatar(
              radius: controller.currentLoginMethod.value == LoginMethod.email
                  ? context.height * .05
                  : context.height * .07,
              backgroundColor: context.colors.surface,
              child: ImageViewer.svgAsset(
                Assets.icons.logo,
                width: controller.currentLoginMethod.value == LoginMethod.email
                    ? context.height * .1
                    : context.height * .25,
                height: controller.currentLoginMethod.value == LoginMethod.email
                    ? context.height * .1
                    : context.height * .25,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }),
    );
  }
}
