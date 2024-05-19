part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyLottieAnimation extends StatelessWidget {
  const BuildVerifyLottieAnimation();

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.animations.otpAnimation,
      width: double.infinity,
      height: context.height * .38,
    );
  }
}
