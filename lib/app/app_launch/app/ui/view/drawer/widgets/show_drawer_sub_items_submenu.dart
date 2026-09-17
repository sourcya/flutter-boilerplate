part of '../../../imports/app_imports.dart';

void showDrawerSubItemsSubmenu(
  BuildContext anchorContext, {
  required String headerTitle,
  required List<({String label, bool isSelected, VoidCallback onTap})> entries,
}) {
  final button = anchorContext.findRenderObject() as RenderBox?;
  if (button == null) return;
  final overlay =
      Overlay.of(anchorContext).context.findRenderObject() as RenderBox?;
  if (overlay == null) return;
  final buttonPosition = button.localToGlobal(Offset.zero, ancestor: overlay);
  final scale = DrawerScale.of(anchorContext);
  final menuWidth = scale.r(224);
  final menuCornerRadius = scale.r(12);
  final gap = scale.r(8);
  final isLtr = Directionality.of(anchorContext) == TextDirection.ltr;

  final RelativeRect position;
  if (isLtr) {
    position = RelativeRect.fromLTRB(
      buttonPosition.dx + button.size.width + gap,
      buttonPosition.dy,
      overlay.size.width - buttonPosition.dx - button.size.width - gap - menuWidth,
      overlay.size.height - buttonPosition.dy - 400,
    );
  } else {
    position = RelativeRect.fromLTRB(
      buttonPosition.dx - gap - menuWidth,
      buttonPosition.dy,
      overlay.size.width - buttonPosition.dx + gap,
      overlay.size.height - buttonPosition.dy - 400,
    );
  }

  showMenu<void>(
    context: anchorContext,
    position: position,
    elevation: 0,
    color: AppColors.transparent,
    shadowColor: AppColors.transparent,
    surfaceTintColor: AppColors.transparent,
    menuPadding: EdgeInsets.zero,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(menuCornerRadius),
    ),
    constraints: BoxConstraints(minWidth: menuWidth, maxWidth: menuWidth),
    items: [
      PopupMenuItem<void>(
        enabled: false,
        height: 0,
        padding: EdgeInsets.zero,
        child: _DrawerSubItemsSubmenuPanel(
          headerTitle: headerTitle,
          entries: entries,
        ),
      ),
    ],
  );
}

class _DrawerSubItemsSubmenuPanel extends StatelessWidget {
  final String headerTitle;
  final List<({String label, bool isSelected, VoidCallback onTap})> entries;

  const _DrawerSubItemsSubmenuPanel({
    required this.headerTitle,
    required this.entries,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final bgColor = context.colors.cardColor;
    final borderColor = context.colors.outlineVariant;
    final mutedTextColor = context.colors.mutedForeground;
    final outerRadius = scale.r(12);
    final innerClipRadius = outerRadius > 1 ? outerRadius - 1 : 0.0;

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: scale.r(224), maxWidth: scale.r(224)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(outerRadius),
          boxShadow: AppShadows.card(context),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(outerRadius),
            border: Border.all(color: borderColor),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(innerClipRadius),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.all(scale.r(4)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: scale.r(8),
                      vertical: scale.r(6),
                    ),
                    child: Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: CustomText(
                        headerTitle,
                        color: mutedTextColor,
                        fontSize: scale.sp(12),
                        fontWeight: FontWeight.w600,
                        height: 1.67,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        isResponsive: false,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: borderColor)),
                  ),
                  padding: EdgeInsets.all(scale.r(4)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final entry in entries)
                        _DrawerSubItemsSubmenuRow(
                          label: entry.label,
                          isSelected: entry.isSelected,
                          onTap: () {
                            Navigator.of(context).pop();
                            entry.onTap();
                          },
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DrawerSubItemsSubmenuRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _DrawerSubItemsSubmenuRow({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final textColor = isSelected ? context.colors.primary : context.colors.foreground;

    return Material(
      color: AppColors.transparent,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(scale.r(4)),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            scale.r(8),
            scale.r(6),
            scale.r(8),
            scale.r(6),
          ),
          child: CustomText(
            label,
            color: textColor,
            fontSize: scale.sp(14),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            height: 1.43,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            isResponsive: false,
          ),
        ),
      ),
    );
  }
}
