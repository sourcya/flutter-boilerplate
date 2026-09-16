part of '../../imports/login_imports.dart';

class LoginPanelIllustrationWidget extends StatelessWidget {
  final String path;

  const LoginPanelIllustrationWidget({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: ResponsiveConfig.animationDuration,
      child: Center(
        key: ValueKey<String>(path),
        child: Lottie.asset(
          path,
          width: context.width,
          height: 440.0.r,
          errorBuilder: (ctx, e, _) => const SizedBox.shrink(),
        ),
      ),
    );
  }
}
