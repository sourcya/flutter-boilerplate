part of '../../imports/splash_imports.dart';

class SplashPoweredByFooter extends GetView<SplashController> {
  const SplashPoweredByFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final footerStyle = context.bodyMediumTS.copyWith(
      color: AppColors.slate50,
      fontSize: 14.sp,
    );

    return Center(
      child: Padding(
        padding: context.paddingOnly(bottom: 8),
        child: Obx(
          () => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                AppTrans.poweredBy,
                textAlign: TextAlign.center,
                textStyle: footerStyle,
              ),
              AppVersion(
                showVersionCode: controller.showVersionCode.value,
                textStyle: footerStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
