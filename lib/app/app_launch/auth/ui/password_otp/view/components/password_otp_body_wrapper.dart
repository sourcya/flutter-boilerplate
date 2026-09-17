part of '../../imports/password_otp_imports.dart';

class PasswordOtpBodyWrapper extends StatelessWidget {
  final bool isWide;

  const PasswordOtpBodyWrapper({
    super.key,
    required this.isWide,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      useSafeArea: false,
      includeAppBar: context.isAppPortrait,
      leading: AppBarLeadingType.back,
      title: '',
      showSupportButton: false,
      backgroundColor: context.colors.background,
      attachPortraitConstraint: !isWide,
      bodyAlignment: Alignment.topCenter,
      child: PasswordOtpShell(isWideLayout: isWide),
    );
  }
}
