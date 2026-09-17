part of '../../imports/password_otp_imports.dart';

class PasswordOtpShell extends StatelessWidget {
  final bool isWideLayout;

  const PasswordOtpShell({
    super.key,
    required this.isWideLayout,
  });

  @override
  Widget build(BuildContext context) {
    return isWideLayout ? const PasswordOtpWideLayout() : const PasswordOtpBody();
  }
}
