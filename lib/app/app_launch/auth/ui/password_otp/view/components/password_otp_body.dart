part of '../../imports/password_otp_imports.dart';

class PasswordOtpBody extends GetView<PasswordOtpController> {
  const PasswordOtpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const PasswordOtpBox(
      child: PasswordOtpFormBody(),
    );
  }
}
