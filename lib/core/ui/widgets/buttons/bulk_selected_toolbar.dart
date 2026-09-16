part of '../../ui.dart';

class BulkSelectedToolbar extends StatelessWidget {
  final String selectedLabel;
  final bool enabled;
  final String deleteMenuTitle;
  final VoidCallback? onDeleteSelected;
  final bool stretchVertically;
  final EdgeInsetsGeometry? selectedPadding;

  const BulkSelectedToolbar({
    super.key,
    required this.selectedLabel,
    required this.enabled,
    required this.deleteMenuTitle,
    this.onDeleteSelected,
    this.stretchVertically = false,
    this.selectedPadding,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final style = context.styles.bodyMedium.copyWith(
      fontSize: 14.sp,
      fontWeight: FontWeight.w600,
      height: 1.71,
      color: colors.primary,
    );

    final buttonPadding = selectedPadding ?? context.paddingSymmetric(horizontal: 12, vertical: 6);

    return ConstrainedBox(
      constraints: stretchVertically
          ? BoxConstraints(minHeight: 40.0.r)
          : BoxConstraints.tightFor(height: 40.0.r),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: enabled ? 1 : 0.5,
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 64.0.r),
              child: ActionButton.outlined(
                title: selectedLabel,
                onPressed: () {},
                backgroundColor: colors.cardColor,
                foregroundColor: colors.primary,
                borderColor: colors.primaryOutlineBorder,
                borderWidth: 1.r,
                borderRadius: BorderRadius.horizontal(
                  left: 12.0.radiusCircular,
                ),
                padding: buttonPadding,
                constraints: BoxConstraints(
                  minWidth: 64.0.r,
                  minHeight: 40.0.r,
                ),
                height: stretchVertically ? null : 40.0.r,
                textStyle: style,
              ),
            ),
          ),
          BulkSelectedArrowButton(
            enabled: enabled,
            deleteMenuTitle: deleteMenuTitle,
            onDeleteSelected: onDeleteSelected,
            stretchVertically: stretchVertically,
          ),
        ],
      ),
    );
  }
}
