part of '../../ui.dart';

class PortraitConstraint extends StatelessWidget {
  final Widget child;

  const PortraitConstraint({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (context.isAppLandscape) return child;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: ResponsiveConfig.maxPortraitWidth,
        ),
        child: child,
      ),
    );
  }
}
