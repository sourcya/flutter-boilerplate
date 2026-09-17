part of '../../../imports/app_imports.dart';

class _DrawerPortraitDivider extends StatelessWidget {
  const _DrawerPortraitDivider();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 16),
      child: Container(
        width: double.infinity,
        height: 1,
        color: context.colors.border,
      ),
    );
  }
}

class CustomDrawerBody extends StatelessWidget {
  final bool isWideWeb;
  final bool isExpanded;
  final StatefulNavigationShell navigationShell;
  const CustomDrawerBody({
    super.key,
    this.isWideWeb = false,
    this.isExpanded = false,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    AppController.instance.drawerIndex = navigationShell.currentIndex;
    final isPortraitDrawer = !isWideWeb && context.isAppPortrait;

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth.isFinite ? constraints.maxWidth : double.infinity;
        const minWidthForProfile = 220.0;
        final showExpandedProfile = isExpanded && maxWidth >= minWidthForProfile;

        return ClipRect(
          child: Container(
            height: constraints.maxHeight,
            width: constraints.maxWidth.isFinite ? constraints.maxWidth : null,
            decoration: isWideWeb
                ? null
                : BoxDecoration(
                    color: context.colors.background,
                    border: BorderDirectional(
                      end: BorderSide(
                        color: context.colors.border,
                        width: 1.r,
                      ),
                    ),
                    borderRadius: !context.isCurrentLocaleArabic
                        ? BorderRadius.only(
                            topRight: 16.radiusCircular,
                            bottomRight: 16.radiusCircular,
                          )
                        : BorderRadius.only(
                            topLeft: 16.radiusCircular,
                            bottomLeft: 16.radiusCircular,
                          ),
                  ),
            child: isWideWeb
                ? Padding(
                    padding: context.paddingSymmetric(
                      horizontal: isExpanded ? 0 : 8,
                      vertical: 4,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildDrawerHeaderWidget(isWideWeb: isWideWeb),
                        BuildDrawerBodyWidget(
                          isWideWeb: isWideWeb,
                          navigationShell: navigationShell,
                        ),
                        BuildDrawerFooterWidget(
                          isWideWeb: isWideWeb,
                          showExpandedProfile: showExpandedProfile,
                        ),
                      ],
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      context.mediaQuery.padding.top.hBox,
                      BuildDrawerHeaderWidget(isWideWeb: isWideWeb),
                      if (isPortraitDrawer) const _DrawerPortraitDivider(),
                      BuildDrawerBodyWidget(
                        isWideWeb: isWideWeb,
                        navigationShell: navigationShell,
                      ),
                      if (isPortraitDrawer) const _DrawerPortraitDivider(),
                      BuildDrawerFooterWidget(
                        isWideWeb: isWideWeb,
                        showExpandedProfile: showExpandedProfile,
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}
