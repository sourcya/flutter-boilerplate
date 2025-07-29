part of '../../imports/splash_imports.dart';

class BuildSplashAppVersionWidget extends GetView<SplashController> {
  const BuildSplashAppVersionWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 30.r,
        horizontal: 10.r,
      ),
      alignment: Alignment.center,
      child: Obx(() {
        return AppVersion(
          showVersionCode: controller.showVersionCode.value,
          textStyle: TextStyle(
            fontSize: 13.sp,
            color: context.colors.primary,
            fontFamily: fontFamily(context: context),
          ),
        );
      }),
    );
  }
}
