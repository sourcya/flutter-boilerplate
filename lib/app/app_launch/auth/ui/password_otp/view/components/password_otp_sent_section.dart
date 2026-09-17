part of '../../imports/password_otp_imports.dart';

class PasswordOtpSentSection extends StatelessWidget {
  const PasswordOtpSentSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const PasswordOtpCodeRemainingTime(),
        const PasswordOtpPinField(),
        4.hBox,
      ],
    );
  }
}
