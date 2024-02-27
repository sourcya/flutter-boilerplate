part of '../imports/login_imports.dart';

// login screen widget.
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OptimizedScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            alignment: Alignment.center,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildLoginLottieAnimation(),
                BuildLoginTitleWidget(),
                BuildLoginEmailFieldWidget(),
                BuildLoginPasswordFieldWidget(),
                BuildLoginButtonWidget(),
                BuildLoginRegisterNowWidget(),
                Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
