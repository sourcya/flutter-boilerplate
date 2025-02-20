part of '../../imports/register_imports.dart';

class BuildRegisterLottieAnimation extends GetView<RegisterController> {
  const BuildRegisterLottieAnimation();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.0.r),
      child: Obx(() {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          child: Padding(
            padding: controller.currentLoginMethod.value == LoginMethod.email
                ? EdgeInsets.only(
                    top: 16.0.r,
                    bottom: 8.r,
                    right: 8.0.r,
                    left: 8.r,
                  )
                : EdgeInsets.only(
                    top: 60.0.r,
                    bottom: 8.r,
                    right: 8.0.r,
                    left: 8.r,
                  ),
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
