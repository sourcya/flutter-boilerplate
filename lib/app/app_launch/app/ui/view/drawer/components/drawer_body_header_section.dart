part of '../../../imports/app_imports.dart';

class BuildDrawerHeaderWidget extends StatelessWidget {
  final bool isWideWeb;

  const BuildDrawerHeaderWidget({
    super.key,
    this.isWideWeb = false,
  });

  @override
  Widget build(BuildContext context) {
    final isExpanded = AppController.instance.drawerController.value.visible;

    if (!isWideWeb) {
      return BuildDrawerUserCardWidget(isExpanded: isExpanded);
    }

    final expandedLogoWidth = (ResponsiveConfig.drawerExpandedRailWidth - 16) * 0.5.r;

    return SizedBox(
      width: isExpanded ? double.infinity : 48.r,
      height: isExpanded ? 56.r : 40.r,
      child: Padding(
        padding: isExpanded
            ? context.paddingSymmetric(horizontal: 8, vertical: 12)
            : context.paddingAll(8),
        child: Align(
          alignment: !isExpanded ? Alignment.center : AlignmentDirectional.centerStart,
          child: ImageViewer.svgAsset(
            isExpanded ? Assets.logos.horizontal : Assets.logos.logo,
            color: context.colors.primary,
            height: isExpanded ? 32.r : 24.r,
            width: isExpanded ? expandedLogoWidth : 24.r,
          ),
        ),
      ),
    );
  }
}
