part of '../../imports/register_imports.dart';

class BuildRegisterDontHaveAccountWidget extends GetView<RegisterController> {
  const BuildRegisterDontHaveAccountWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 5.h,
      ),
      child: InkWell(
        onTap: controller.navigateToLogin,
        child: RichText(
          text: TextSpan(
            text: AppTrans.haveAccountText.tr(context: context),
            style: TextStyle(
              // color: context.colors.onSurface,
              fontSize: 14.sp,
            ),
            children: <TextSpan>[
              TextSpan(
                text: AppTrans.loginNow.tr(context: context),
                style: TextStyle(
                  // color: context.colors.secondary,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
