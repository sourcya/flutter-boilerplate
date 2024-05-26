part of '../../imports/splash_imports.dart';

class _BuildSplashLogoWidget extends GetView<SplashController> {
  const _BuildSplashLogoWidget();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width * .6,
      height: context.height * .6,
      child: SvgPicture.asset(
        Assets.icons.logo,
      ),
    )
        .animate(
          delay: 300.milliseconds,
          onComplete: controller.handleAnimationCompleted,
        )
        .fadeIn(duration: 750.milliseconds)
        .scale(duration: 1.seconds, curve: Curves.easeInOut)
        .then()
        .shimmer(duration: 1.seconds);
  }
}
