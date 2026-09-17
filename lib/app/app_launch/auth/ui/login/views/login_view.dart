part of '../imports/login_imports.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlayxThemeSwitchingArea(
      child: KeyboardVisibilityProvider(
        child: CustomResponsiveBuilder(
          mobileBuilder: (context, info) =>
              const LoginBodyWrapperWidget(isWide: false),
          tabletBuilder: (context, info) => LoginBodyWrapperWidget(
            isWide: context.isAppLandscape,
          ),
          desktopBuilder: (context, info) =>
              const LoginBodyWrapperWidget(isWide: true),
        ),
      ),
    );
  }
}
