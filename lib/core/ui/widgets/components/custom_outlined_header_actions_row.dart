part of '../../ui.dart';

enum CustomOutlinedHeaderAction {
  update,
  delete,
  template,
}

/// Outlined header actions for landscape details cards.
class CustomOutlinedHeaderActionsRow extends StatelessWidget {
  final List<CustomOutlinedHeaderAction> actions;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onSetAsTemplate;
  final bool isEditEnabled;

  const CustomOutlinedHeaderActionsRow({
    super.key,
    this.actions = const [
      CustomOutlinedHeaderAction.delete,
      CustomOutlinedHeaderAction.update,
    ],
    this.onEdit,
    this.onDelete,
    this.onSetAsTemplate,
    this.isEditEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final children = <Widget>[];

    for (final action in actions) {
      switch (action) {
        case CustomOutlinedHeaderAction.delete:
          children.add(
            CustomOutlinedHeaderActionButton(
              title: AppTrans.delete,
              onPressed: onDelete,
              isDestructive: true,
              icon: IconInfo.svg(Asset.icons.icDelete),
            ),
          );
        case CustomOutlinedHeaderAction.update:
          children.add(
            CustomOutlinedHeaderActionButton(
              title: AppTrans.edit,
              onPressed: isEditEnabled ? onEdit : null,
              icon: IconInfo.svg(Asset.icons.icEdit),
            ),
          );
        case CustomOutlinedHeaderAction.template:
          children.add(
            CustomOutlinedHeaderActionButton(
              title: AppTrans.setAsTemplate,
              onPressed: onSetAsTemplate,
              icon: IconInfo.svg(Asset.icons.icTemplate),
            ),
          );
      }
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.r,
      children: children,
    );
  }
}
