part of '../../../imports/app_imports.dart';

class DrawerExpandableSubItemRow extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const DrawerExpandableSubItemRow({
    super.key,
    required this.label,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final isPortraitDrawer = context.isAppPortrait;
    final usesLightDrawerChrome = !context.isDarkMode && isPortraitDrawer;
    final textColor = isSelected
        ? context.colors.primary
        : (usesLightDrawerChrome ? AppColors.slate.slate700 : context.colors.foreground);

    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: scale.r(128)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(scale.r(6)),
        splashColor: context.colors.primary.withValues(alpha: 0.1),
        child: Container(
          width: context.width,
          padding: EdgeInsets.symmetric(horizontal: scale.r(8), vertical: scale.r(6)),
          child: CustomText(
            label,
            textStyle: context.bodyMediumTS.copyWith(
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: textColor,
            ),
            fontSize: 14,
            isResponsive: false,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ),
    );
  }
}
