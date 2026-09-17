part of '../../../imports/app_imports.dart';

class BuildDrawerItemWidget extends StatelessWidget {
  final VoidCallback? onTap;
  final CustomNavigationDestinationItem item;
  final bool isSelected;
  final bool isExpanded;
  final Color? color;
  final bool isWideWeb;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final Widget? trailing;

  const BuildDrawerItemWidget({
    super.key,
    this.onTap,
    required this.item,
    this.isSelected = false,
    this.isExpanded = true,
    this.color,
    this.isWideWeb = false,
    this.padding,
    this.borderRadius,
    this.fontWeight,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final isPortraitDrawer = !isWideWeb && context.isAppPortrait;
    final usesLightDrawerChrome = !context.isDarkMode && (isWideWeb || isPortraitDrawer);
    final defaultUnselectedColor = usesLightDrawerChrome
        ? AppColors.slate.slate700
        : context.colors.foreground;
    final selectedBackground = context.isDarkMode
        ? AppColors.primaryPalette.primary300
        : (isPortraitDrawer
              ? AppColors.primaryPalette.primary950
              : isWideWeb
              ? AppColors.primaryPalette.primary950
              : context.colors.primary);
    final selectedForeground = context.isDarkMode
        ? AppColors.primaryPalette.primary950
        : context.colors.onPrimary;
    final contentColor = color ?? (isSelected ? selectedForeground : defaultUnselectedColor);
    final tileBorderRadius = borderRadius != null
        ? borderRadius?.radius
        : (isPortraitDrawer ? 8.0 : 6.0).radius;
    final tilePadding =
        padding ??
        (isPortraitDrawer
            ? context.paddingAll(8)
            : isWideWeb && isExpanded
            ? context.paddingAll(8)
            : isWideWeb && !isExpanded
            ? context.paddingSymmetric(vertical: 6)
            : context.paddingSymmetric(horizontal: 8, vertical: 6));
    final isCollapsedRail = isWideWeb && !isExpanded;
    final showLabel = isExpanded && !isCollapsedRail;
    final itemHeight = isPortraitDrawer
        ? 40.r
        : isCollapsedRail
        ? scale.railChromeTileHeight
        : 36.r;

    return ActionButton.outlined(
      onPressed: onTap,
      title: showLabel ? item.label : '',
      backgroundColor: isSelected ? selectedBackground : AppColors.transparent,
      foregroundColor: contentColor,
      borderRadius: tileBorderRadius,
      padding: tilePadding,
      constraints: BoxConstraints(
        minWidth: context.width,
        minHeight: itemHeight,
        maxHeight: itemHeight,
      ),
      alignment: isCollapsedRail ? Alignment.center : AlignmentDirectional.centerStart,
      isIconPositionLeft: true,
      trailingIcon: isCollapsedRail ? null : trailing,
      icon: Container(
        width: 16.r,
        height: 16.r,
        alignment: Alignment.center,
        child: item.icon.buildIconWidget(
          color: contentColor,
          size: 16.r,
        ),
      ),
      textStyle: context.styles.bodyMedium.copyWith(
        color: contentColor,
        fontWeight: fontWeight ?? FontWeight.w400,
        height: 1.43,
      ),
    );
  }
}
