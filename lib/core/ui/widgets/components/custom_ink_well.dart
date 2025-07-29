part of '../../ui.dart';

class CustomInkWell extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final BorderRadius? borderRadius;

  const CustomInkWell({
    this.onTap,
    this.borderRadius,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: borderRadius ?? Style.cardBorderRadius,
        child: child,
      ),
    );
  }
}
