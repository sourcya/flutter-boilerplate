part of '../../imports/splash_imports.dart';

class SplashLogoWidget extends GetView<SplashController> {
  const SplashLogoWidget({super.key});

  static const double _portraitFactor = 0.42;
  static const double _landscapeFactor = 0.18;

  @override
  Widget build(BuildContext context) {
    final maxSize = 180.r;
    final factor =
        context.isAppLandscape ? _landscapeFactor : _portraitFactor;
    final size = (context.width * factor).clamp(96.0, maxSize);

    return ImageViewer.svgAsset(
          Assets.logos.logo,
          color: AppColors.slate50,
          width: size,
          height: size,
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
