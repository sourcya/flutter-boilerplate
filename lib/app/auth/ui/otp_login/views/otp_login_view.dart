part of '../imports/login_view_imports.dart';

// login screen widget.
class OtpLoginView extends GetView<OtpLoginController> {
  const OtpLoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OptimizedScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 8.h,
              horizontal: 16.w,
            ),
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
      ),
    );
  }
}
