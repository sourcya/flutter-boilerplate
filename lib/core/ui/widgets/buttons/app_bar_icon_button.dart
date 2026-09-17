part of '../../ui.dart';

/// App bar leading action (back, menu) using [ActionButton].
class AppBarIconButton extends StatelessWidget {
  final IconInfo icon;
  final VoidCallback? onTap;
  final bool isFlippedForRtl;

  const AppBarIconButton({
    super.key,
    required this.icon,
    this.onTap,
    this.isFlippedForRtl = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = icon.buildIconWidget(color: context.colors.onAppBar);
    if (isFlippedForRtl && context.isRtl) {
      iconWidget = Transform.flip(
        flipX: true,
        child: iconWidget,
      );
    }

    final button = ActionButton.outlined(
      onPressed: onTap,
      backgroundColor: context.colors.colorScheme.surfaceContainerHigh,
      foregroundColor: context.colors.onAppBar,
      borderRadius: 8.0.radius,
      constraints: BoxConstraints.tightFor(
        height: 28.0.r,
        width: 28.0.r,
      ),
      padding: context.paddingAll(6.0),
      icon: iconWidget,
    );

    if (PlayxPlatform.isCupertino) {
      return button;
    }
    return Center(child: button);
  }
}
