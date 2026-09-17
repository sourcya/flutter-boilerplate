part of '../../ui.dart';

/// Outlined edit + delete icon actions for entity details app bars and headers.
class AppOutlinedEditDeleteActionsRow extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isEditEnabled;
  final bool showDelete;

  const AppOutlinedEditDeleteActionsRow({
    super.key,
    required this.onEdit,
    required this.onDelete,
    this.isEditEnabled = true,
    this.showDelete = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.r,
      children: [
        ActionButton.outlined(
          onPressed: isEditEnabled ? onEdit : null,
          backgroundColor: colors.cardColor,
          foregroundColor: colors.primary,
          borderColor: colors.primaryOutlineBorder,
          borderRadius: 8.radius,
          padding: context.paddingAll(6),
          constraints: BoxConstraints.tightFor(
            width: 32.r,
            height: 32.r,
          ),
          icon: IconInfo.svg(Asset.icons.icEdit).buildIconWidget(
            color: colors.primary,
            size: 16.r,
          ),
        ),
        if (showDelete)
          ActionButton.outlined(
            onPressed: onDelete,
            backgroundColor: colors.cardColor,
            foregroundColor: AppColors.semanticDestructive,
            borderColor: colors.deleteButtonBorderColor,
            borderRadius: 8.radius,
            padding: context.paddingAll(6),
            constraints: BoxConstraints.tightFor(
              width: 32.r,
              height: 32.r,
            ),
            icon: IconInfo.svg(Asset.icons.icDelete).buildIconWidget(
              color: AppColors.semanticDestructive,
              size: 16.r,
            ),
          ),
      ],
    );
  }
}
