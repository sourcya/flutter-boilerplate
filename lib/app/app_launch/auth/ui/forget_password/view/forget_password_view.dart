part of '../imports/forget_password_imports.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomResponsiveBuilder(
      mobileBuilder: (context, info) => const ForgetPasswordBodyWrapper(isWide: false),
      tabletBuilder: (context, info) => ForgetPasswordBodyWrapper(
        isWide: context.isAppLandscape,
      ),
      desktopBuilder: (context, info) => const ForgetPasswordBodyWrapper(isWide: true),
    );
  }
}
