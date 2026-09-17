part of '../../imports/onboarding_imports.dart';

/// Centered illustration inside the onboarding hero frame.
class OnboardingHeroSvgWidget extends StatelessWidget {
  final String assetPath;
  final double widthFactor;
  final double? height;
  final bool animateChanges;

  const OnboardingHeroSvgWidget({
    super.key,
    required this.assetPath,
    this.widthFactor = 0.85,
    this.height,
    this.animateChanges = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = height ?? context.width * widthFactor;
    final image = Lottie.asset(
      assetPath,
      key: animateChanges ? ValueKey<String>(assetPath) : null,
      width: size,
      height: size,
      fit: BoxFit.contain,
      errorBuilder: (ctx, e, _) => const SizedBox.shrink(),
    );

    if (!animateChanges) {
      return image;
    }

    return AnimatedSwitcher(
      duration: ResponsiveConfig.animationDuration,
      child: image,
    );
  }
}
