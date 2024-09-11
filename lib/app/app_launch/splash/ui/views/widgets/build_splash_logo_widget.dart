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
          delay: const Duration(milliseconds: 300),
          onComplete: controller.handleAnimationCompleted,
        )
        .fadeIn(duration: const Duration(milliseconds: 750))
        .scale(duration: const Duration(seconds: 1), curve: Curves.easeInOut)
        .then()
        .shimmer(duration: const Duration(seconds: 1));
  }
}
