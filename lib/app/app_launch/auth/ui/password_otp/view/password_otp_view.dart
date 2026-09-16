part of '../imports/password_otp_imports.dart';

class PasswordOtpView extends StatelessWidget {
  const PasswordOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      mobileBuilder: (context, info) => const PasswordOtpBodyWrapper(isWide: false),
      tabletBuilder: (context, info) => PasswordOtpBodyWrapper(
        isWide: context.isAppLandscape,
      ),
      desktopBuilder: (context, info) => const PasswordOtpBodyWrapper(isWide: true),
    );
  }
}
