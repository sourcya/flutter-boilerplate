part of '../../../../imports/app_imports.dart';

class BuildDrawerItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final CustomNavigationDestinationItem item;
  final bool isSelected;
  final bool isExpanded;

  const BuildDrawerItemWidget({
    super.key,
    this.onTap,
    required this.item,
    this.isSelected = false,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    final contentColor = isSelected
        ? context.colors.onPrimary
        : context.colors.onSurface;

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: isExpanded ? 8.r : 6.r,
        vertical: isExpanded
            ? dimens.drawerItemTileVerticalContentPadding
            : 2.r,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        splashColor: context.colors.primary.withValues(alpha: 0.1),
        child: AnimatedContainer(
          duration: 250.milliseconds,
          curve: Curves.easeOutCubic,
          padding: EdgeInsets.symmetric(
            vertical: isExpanded ? 8.r : 0,
            horizontal: isExpanded ? 8.r : 0,
          ),
          // width: isExpanded ? null : 36.r,
          height: isExpanded ? null : 36.r,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? context.colors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ClipRect(
            child: Row(
              mainAxisAlignment: isExpanded
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: [
                // ICON
                item.icon.buildIconWidget(
                  color: contentColor,
                  size: item.icon.size ?? (22.r - (isExpanded ? 4.r : 4.r)),
                ),

                if (isExpanded)
                  // LABEL (no overflow ever)
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: 200.milliseconds,
                      switchInCurve: Curves.easeOut,
                      switchOutCurve: Curves.easeIn,
                      child: isExpanded
                          ? Container(
                              alignment: AlignmentDirectional.centerStart,
                              padding: EdgeInsets.only(left: 6.r, right: 8.r),
                              child: CustomText(
                                item.label,
                                color: contentColor,
                                fontSize: dimens.drawerItemTextSize,
                                fontWeight: FontWeight.w400,
                                maxLines: 1,
                                textOverflow: TextOverflow.fade,
                                softWrap: false,
                              ),
                            )
                          : const SizedBox.shrink(),
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
