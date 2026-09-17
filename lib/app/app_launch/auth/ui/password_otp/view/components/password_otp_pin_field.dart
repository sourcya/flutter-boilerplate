part of '../../imports/password_otp_imports.dart';

class PasswordOtpPinField extends GetView<PasswordOtpController> {
  const PasswordOtpPinField();

  @override
  Widget build(BuildContext context) {
    final gap = 10.r;
    final cellWidth = context.isAppLandscape ? 56.r : 52.r;
    final cellHeight = context.isAppLandscape ? 64.r : 60.r;
    final totalWidth = (cellWidth * 6) + (gap * 5);

    final defaultPinTheme = PinTheme(
      width: cellWidth,
      height: cellHeight,
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: context.colors.onSurface,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.border),
        borderRadius: 16.0.radius,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: context.colors.primary),
        borderRadius: 16.0.radius,
      ),
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: context.colors.onSurface,
        fontWeight: FontWeight.w600,
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: context.colors.secondary,
      ),
      textStyle: TextStyle(
        fontSize: 24.sp,
        color: context.colors.onPrimary,
        fontWeight: FontWeight.w600,
      ),
    );

    return Padding(
      padding: context.paddingSymmetric(vertical: 8),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Center(
          child: SizedBox(
            width: totalWidth,
            height: cellHeight,
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              separatorBuilder: (index) => gap.wBox,
              onChanged: (s) {
                controller.currentPin.value = s;
                controller.isOtpValid.value = s.length == 6;
              },
              onCompleted: (s) {
                controller.currentPin.value = s;
                controller.isOtpValid.value = s.length == 6;
                controller.verifyOtp();
              },
              pinputAutovalidateMode: PinputAutovalidateMode.disabled,
              scrollPadding: context
                  .paddingOnly(bottom: 80)
                  .resolve(Directionality.of(context)),
            ),
          ),
        ),
      ),
    );
  }
}
