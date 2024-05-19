part of '../../imports/register_imports.dart';

class BuildRegisterLottieAnimation extends StatelessWidget {
  const BuildRegisterLottieAnimation();

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      Assets.animations.registerAnimation,
      width: double.infinity,
      height: context.height * .28,
    );
  }
}
