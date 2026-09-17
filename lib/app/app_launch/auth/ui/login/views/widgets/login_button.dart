part of '../../imports/login_imports.dart';

class LoginButton extends GetView<LoginController> {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final isLoading =
            AppController.instance.loadingStatus.value is! LoadingStatusIdle;
        final isFormValid = controller.isFormValid.value;

        final enabledFg =
            context.colors.onButtonColor ?? context.colors.onPrimary;
        final disabledFg =
            context.colors.subtitleTextColor ?? context.colors.mutedForeground;

        final fg = isFormValid ? enabledFg : disabledFg;

        return ActionButton(
          title: AppTrans.signInLabel,
          onPressed: isFormValid ? controller.signIn : null,
          isLoading: isLoading,
          backgroundColor: context.colors.borderColor.withValues(alpha: 0.4),
          foregroundColor: fg,
          disabledBackgroundColor:
              context.colors.borderColor.withValues(alpha: 0.4),
          gradient: isFormValid
              ? LinearGradient(
                  begin: AlignmentDirectional.topStart,
                  end: AlignmentDirectional.bottomEnd,
                  colors: [
                    context.colors.buttonBackgroundColor ??
                        context.colors.primary,
                    context.colors.gradientLoginEnd,
                  ],
                )
              : null,
          padding: context.paddingSymmetric(horizontal: 24, vertical: 12),
          constraints:
              BoxConstraints.tightFor(width: context.width, height: 48.0.r),
          borderRadius: 12.radius,
          isIconPositionLeft: true,
          icon: IconInfo.svg(
            Assets.icons.icLogin,
            color: fg,
            size: 16.r,
          ).buildIconWidget(),
          textStyle: context.bodyMediumTS.copyWith(
            color: fg,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            height: 1.71,
          ),
        );
      },
    );
  }
}
