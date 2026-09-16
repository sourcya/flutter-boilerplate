part of '../../imports/password_otp_imports.dart';

class PasswordOtpCodeNotReceived extends GetView<PasswordOtpController> {
  const PasswordOtpCodeNotReceived();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 8.r,
      runSpacing: 4.r,
      children: [
        CustomText(
          AppTrans.passwordOtpCodeNotReceived,
          textAlign: TextAlign.center,
          textStyle: context.bodyMediumTS.copyWith(
            color: context.colors.mutedForeground,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        WebSelectionDisabledGestureDetector(
          onTap: controller.resendOtpCode,
          child: CustomText(
            AppTrans.passwordOtpResendCode,
            textAlign: TextAlign.center,
            textStyle: context.bodyMediumTS.copyWith(
              color: RehlaColorTokens.secondary600,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              height: 1.43,
            ),
          ),
        ),
      ],
    );
  }
}
