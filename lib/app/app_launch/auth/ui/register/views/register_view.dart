part of '../imports/register_imports.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OptimizedScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            alignment: Alignment.center,
            child: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BuildRegisterLottieAnimation(),
                BuildRegisterTitleWidget(),
                BuildRegisterEmailFieldWidget(),
                BuildRegisterPasswordFieldWidget(),
                BuildRegisterConfirmPasswordWidget(),
                BuildRegisterButtonWidget(),
                BuildRegisterDontHaveAccountWidget(),
                BuildRegisterTermsAndConditionsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
