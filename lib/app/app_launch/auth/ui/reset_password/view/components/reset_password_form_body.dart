part of '../../imports/reset_password_imports.dart';

class ResetPasswordFormBody extends GetView<ResetPasswordController> {
  final bool isWideLayout;

  const ResetPasswordFormBody({
    super.key,
    this.isWideLayout = false,
  });

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isWideLayout) ...[
            CustomText(
              AppTrans.resetPasswordTitle,
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
              height: 1.20,
              letterSpacing: -0.75,
              color: context.colors.foreground,
            ),
            4.hBox,
            CustomText(
              AppTrans.resetPasswordSubtitle,
              textStyle: context.bodyMediumTS.copyWith(
                color: context.colors.mutedForeground,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
            40.hBox,
          ],
          CustomText(
            AppTrans.passwordLabel,
            textStyle: context.headlineSmallTS.copyWith(
              color: context.colors.foreground,
              fontSize: 14.sp,
              height: 1.43,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.hBox,
          const ResetPasswordNewPasswordField(),
          40.hBox,
          CustomText(
            AppTrans.confirmPasswordLabel,
            textStyle: context.headlineSmallTS.copyWith(
              color: context.colors.foreground,
              fontSize: 14.sp,
              height: 1.43,
              fontWeight: FontWeight.w600,
            ),
          ),
          8.hBox,
          const ResetPasswordConfirmPasswordField(),
          40.hBox,
          const ResetPasswordSubmitButton(),
        ],
      ),
    );
  }
}
