part of '../../ui.dart';

/// Icon trigger for [CustomPopupMenu] (table actions, list card overflow, etc.).
///
/// When [menuItems] is empty or null and [onPressed] is set, acts as a plain tap target.
class PopupMenuIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final List<CustomPopupMenuItem<String>>? menuItems;
  final Offset popupOffset;
  final bool showBorder;

  const PopupMenuIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.menuItems,
    this.popupOffset = const Offset(0, 40),
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final shell = _PopupMenuIconButtonShell(
      icon: icon,
      showBorder: showBorder,
    );

    if (menuItems == null || menuItems?.isEmpty == true) {
      if (onPressed == null) {
        return shell;
      }
      return InkWell(
        onTap: onPressed,
        borderRadius: 8.0.radius,
        child: shell,
      );
    }

    return CustomPopupMenu<String>(
      items: menuItems ?? [],
      showBorder: false,
      offset: popupOffset,
      customChild: shell,
    );
  }
}

class _PopupMenuIconButtonShell extends StatelessWidget {
  final Widget icon;
  final bool showBorder;

  const _PopupMenuIconButtonShell({
    required this.icon,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    if (!showBorder) {
      return Padding(
        padding: context.paddingAll(8),
        child: icon,
      );
    }

    return Container(
      width: 32.0.r,
      height: 32.0.r,
      alignment: AlignmentDirectional.center,
      padding: context.paddingAll(8.0),
      decoration: BoxDecoration(
        color: context.colors.cardColor,
        borderRadius: 8.0.radius,
        border: Border.all(color: context.colors.primaryContainer),
      ),
      child: icon,
    );
  }
}
