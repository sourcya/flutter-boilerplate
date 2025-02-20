part of '../../imports/register_imports.dart';

class BuildRegisterHaveAccountWidget extends GetView<RegisterController> {
  const BuildRegisterHaveAccountWidget();

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
              color: context.colors.subtitleTextColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              fontFamily: fontFamily,
            ),
            children: <TextSpan>[
              TextSpan(
                text: AppTrans.loginNow.tr(context: context),
                style: TextStyle(
                  color: context.colors.primary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: fontFamily,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
