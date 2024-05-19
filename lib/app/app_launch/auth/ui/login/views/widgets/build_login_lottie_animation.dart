part of '../../imports/login_imports.dart';

class BuildLoginLottieAnimation extends StatelessWidget {
  const BuildLoginLottieAnimation();

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.animations.loginAnimation,
      width: double.infinity,
      height: context.height * .35,
    );
  }
}
