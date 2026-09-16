part of '../../imports/password_otp_imports.dart';

class PasswordOtpExpiredBanner extends GetView<PasswordOtpController> {
  const PasswordOtpExpiredBanner();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: context.paddingSymmetric(horizontal: 2, vertical: 8),
          child: CustomText(
            AppTrans.passwordOtpExpiredMessage,
            color: context.colors.error,
            textAlign: TextAlign.center,
            textStyle: context.bodyMediumTS.copyWith(
              color: context.colors.error,
            ),
          ),
        ),
        8.hBox,
      ],
    );
  }
}
