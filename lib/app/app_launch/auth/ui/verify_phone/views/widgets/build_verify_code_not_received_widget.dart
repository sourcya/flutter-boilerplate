part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyCodeNotReceivedWidget extends GetView<VerifyPhoneController> {
  const BuildVerifyCodeNotReceivedWidget();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildDidNotReceiveCodeText(context),
        _buildResendCodeButton(context),
      ],
    );
  }

  Widget _buildDidNotReceiveCodeText(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
      ),
      child: CustomText(
        AppTrans.verifyPhoneCodeNotReceived,
        fontSize: 15.sp,
        color: Colors.grey,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildResendCodeButton(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 8.h,
      ),
      child: TextButton(
        onPressed: controller.resendCode,
        child: CustomText(
          AppTrans.resendCode,
          fontSize: 15.sp,
          // color: context.colors.primary,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
