part of '../../imports/password_otp_imports.dart';

class PasswordOtpAction extends GetView<PasswordOtpController> {
  const PasswordOtpAction();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isOtpExpired.value) {
        const fg = AppColors.basewhite;
        return ActionButton(
          title: AppTrans.passwordOtpResendCode,
          onPressed: controller.resendOtpCode,
          isLoading: controller.isLoading.value,
          backgroundColor: context.colors.loginDisabledColor,
          foregroundColor: fg,
          disabledBackgroundColor: context.colors.loginDisabledColor,
          gradient: AppColors.gradient(
            begin: const Alignment(0.00, 0.50),
            end: const Alignment(1.00, 0.50),
          ),
          padding: context.paddingSymmetric(horizontal: 24, vertical: 12),
          constraints: BoxConstraints.tightFor(width: context.width, height: 48.0.r),
          borderRadius: 12.radius,
          textStyle: context.bodyMediumTS.copyWith(
            color: fg,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.71,
          ),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const PasswordOtpConfirmButton(),
          16.hBox,
          const PasswordOtpCodeNotReceived(),
        ],
      );
    });
  }
}
