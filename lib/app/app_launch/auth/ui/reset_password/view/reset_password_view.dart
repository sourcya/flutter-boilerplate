part of '../imports/reset_password_imports.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      mobileBuilder: (context, info) => const ResetPasswordBodyWrapper(isWide: false),
      tabletBuilder: (context, info) => ResetPasswordBodyWrapper(
        isWide: context.isAppLandscape,
      ),
      desktopBuilder: (context, info) => const ResetPasswordBodyWrapper(isWide: true),
    );
  }
}
