part of '../../imports/forget_password_imports.dart';

class ForgetPasswordFormBody extends GetView<ForgetPasswordController> {
  final bool isWideLayout;

  const ForgetPasswordFormBody({
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
              AppTrans.forgetPasswordText,
              fontSize: 30.sp,
              fontWeight: FontWeight.w600,
              height: 1.20,
              letterSpacing: -0.75,
              color: context.colors.foreground,
            ),
            4.hBox,
            CustomText(
              AppTrans.forgetPasswordSubtitle,
              textStyle: context.bodyMediumTS.copyWith(
                color: context.colors.mutedForeground,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                height: 1.43,
              ),
            ),
            40.hBox,
          ],
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                isWideLayout ? AppTrans.emailLabelWideLandscape : AppTrans.emailLabel,
                textStyle: context.headlineSmallTS.copyWith(
                  color: context.colors.foreground,
                  fontSize: 14.sp,
                  height: 1.43,
                  fontWeight: FontWeight.w600,
                ),
              ),
              8.hBox,
              const BuildForgetPasswordEmailFieldWidget(),
            ],
          ),
          40.hBox,
          const BuildForgetPasswordSendButton(),
        ],
      ),
    );
  }
}
