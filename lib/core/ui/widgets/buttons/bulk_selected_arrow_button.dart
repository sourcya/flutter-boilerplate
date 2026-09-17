part of '../../ui.dart';

class BulkSelectedArrowButton extends StatelessWidget {
  final bool enabled;
  final String deleteMenuTitle;
  final VoidCallback? onDeleteSelected;
  final bool stretchVertically;

  const BulkSelectedArrowButton({
    super.key,
    required this.enabled,
    required this.deleteMenuTitle,
    this.onDeleteSelected,
    this.stretchVertically = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final button = ActionButton.outlined(
      onPressed: () {},
      visualOnly: true,
      backgroundColor: colors.cardColor,
      foregroundColor: colors.primary,
      borderColor: colors.primaryOutlineBorder,
      borderWidth: 1.r,
      borderRadius: BorderRadius.horizontal(right: 12.0.radiusCircular),
      width: stretchVertically ? null : 40.r,
      height: stretchVertically ? null : 40.0.r,
      constraints: BoxConstraints(minWidth: 40.0.r, minHeight: 40.0.r),
      padding: stretchVertically ? context.paddingAll(12) : context.paddingZero(),
      icon: IconInfo.icon(Icons.keyboard_arrow_down).buildIconWidget(
        size: 16.r,
        color: colors.primary,
      ),
    );

    final shell = Opacity(
      opacity: enabled ? 1 : 0.4,
      child: button,
    );

    if (!enabled || onDeleteSelected == null) {
      return shell;
    }

    return CustomPopupMenu<String>(
      showBorder: false,
      offset: Offset(0, 40.0.r),
      items: [
        CustomPopupMenuItem(
          title: deleteMenuTitle,
          onTap: onDeleteSelected,
          textColor: AppColors.semanticDestructive,
          icon: IconInfo.svg(
            Asset.icons.icDelete,
            size: 16.r,
            color: AppColors.semanticDestructive,
          ),
        ),
      ],
      customChild: shell,
    );
  }
}
