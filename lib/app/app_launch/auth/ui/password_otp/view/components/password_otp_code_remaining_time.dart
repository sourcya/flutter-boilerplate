part of '../../imports/password_otp_imports.dart';

class PasswordOtpCodeRemainingTime extends GetView<PasswordOtpController> {
  const PasswordOtpCodeRemainingTime();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(vertical: 12),
      child: TimerRefreshWidget(
        duration: const Duration(seconds: 1),
        builder: (_) {
          return CustomText(
            AppTrans.remainingOtpCodeTimeValidMessage.tr(
              context: context,
              args: [controller.remainingMinutes, controller.remainingSeconds],
            ),
            color: context.colors.mutedForeground,
            textAlign: TextAlign.center,
            textStyle: context.bodyMediumTS.copyWith(
              color: context.colors.mutedForeground,
              fontSize: 14.sp,
            ),
            isTranslatable: false,
          );
        },
      ),
    );
  }
}
