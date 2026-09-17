part of '../../imports/login_imports.dart';

class LoginForgotPassword extends GetView<LoginController> {
  const LoginForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return ActionButton.outlined(
      title: AppTrans.forgetPasswordText,
      onPressed: controller.onForgotPassword,
      backgroundColor: AppColors.transparent,
      foregroundColor: context.colors.primary,
      padding: context.paddingZero(),
      textStyle: context.labelLargeTS.copyWith(
        color: context.colors.primary,
        fontWeight: FontWeight.w600,
        height: 1.43,
      ),
    );
  }
}
