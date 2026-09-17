part of '../../imports/password_otp_imports.dart';

class PasswordOtpConfirmButton extends GetView<PasswordOtpController> {
  const PasswordOtpConfirmButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isOtpValid = controller.isOtpValid.value;
      const enabledFg = AppColors.basewhite;
      final disabledFg = context.colors.subtitleTextColor ?? context.colors.mutedForeground;
      final fg = isOtpValid ? enabledFg : disabledFg;

      return ActionButton(
        title: AppTrans.passwordOtpVerify,
        onPressed: isOtpValid ? controller.verifyOtp : null,
        isLoading: controller.isLoading.value,
        backgroundColor: context.colors.loginDisabledColor,
        foregroundColor: fg,
        disabledBackgroundColor: context.colors.loginDisabledColor,
        gradient: isOtpValid
            ? AppColors.gradient(
                begin: const Alignment(0.00, 0.50),
                end: const Alignment(1.00, 0.50),
              )
            : null,
        padding: context.paddingSymmetric(horizontal: 24, vertical: 12),
        constraints: BoxConstraints(minWidth: context.width, maxWidth: context.width),
        borderRadius: 12.radius,
        textStyle: context.bodyMediumTS.copyWith(
          color: fg,
          fontSize: 14.sp,
          fontWeight: FontWeight.w600,
          height: 1.71,
        ),
      );
    });
  }
}
