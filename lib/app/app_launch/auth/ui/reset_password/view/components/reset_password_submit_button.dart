part of '../../imports/reset_password_imports.dart';

class ResetPasswordSubmitButton extends GetView<ResetPasswordController> {
  const ResetPasswordSubmitButton();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isFormValid = controller.isFormValid.value;
      final enabledFg = context.colors.onPrimary;
      final disabledFg = context.colors.subtitleTextColor ?? context.colors.mutedForeground;
      final fg = isFormValid ? enabledFg : disabledFg;

      return ActionButton(
        title: AppTrans.resetPasswordButtonText,
        onPressed: isFormValid ? controller.resetPassword : null,
        isLoading: controller.isLoading.value,
        backgroundColor: context.colors.inputBorderColor.withValues(alpha: 0.4),
        foregroundColor: fg,
        disabledBackgroundColor: context.colors.inputBorderColor.withValues(alpha: 0.4),
        gradient: isFormValid
            ? LinearGradient(
                begin: AlignmentDirectional.topStart,
                end: AlignmentDirectional.bottomEnd,
                colors: [
                  context.colors.primary,
                  context.colors.gradientLoginEnd,
                ],
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
