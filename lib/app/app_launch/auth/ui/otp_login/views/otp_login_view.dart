part of '../imports/login_view_imports.dart';

// login screen widget.
class OtpLoginView extends GetView<OtpLoginController> {
  const OtpLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: const SafeArea(
        child: OptimizedScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              BuildLoginLottieAnimation(),
              BuildLoginText(),
              BuildLoginSubtitleText(),
              BuildMobileLoginTextField(),
              BuildLoginButton(),
            ],
          ),
        ),
      ),
    );
  }
}
