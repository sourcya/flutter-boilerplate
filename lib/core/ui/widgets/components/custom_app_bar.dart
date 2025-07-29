part of '../../ui.dart';

enum AppBarLeadingType {
  none,
  back,
  drawer,
  navigationRail,
  drawerOrRail;

  Widget buildWidget(BuildContext context) {
    switch (this) {
      case AppBarLeadingType.none:
        return const SizedBox.shrink();
      case AppBarLeadingType.back:
        return Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(
                PlayxPlatform.isIOS ? CupertinoIcons.back : Icons.arrow_back,
                color: context.colors.primary,
              ),
              onPressed: () {
                PlayxNavigation.pop();
              },
            );
          },
        );
      case AppBarLeadingType.drawer:
        return IconButton(
          icon: Icon(
            Icons.menu,
            color: context.colors.onSurface,
          ),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      case AppBarLeadingType.drawerOrRail:
        return NavigationUtils.canShowDrawer
            ? IconButton(
                icon: Icon(
                  Icons.menu,
                  color: context.colors.onSurface,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              )
            : const SizedBox.shrink();
      case AppBarLeadingType.navigationRail:
        return const SizedBox.shrink();
    }
  }

  bool get canShowDrawer =>
      this == AppBarLeadingType.drawer ||
      (this == AppBarLeadingType.drawerOrRail && AppUtils.isMobile());

  bool get canShowBack => this == AppBarLeadingType.back;

  bool get canShowNavigationRail =>
      this == AppBarLeadingType.navigationRail ||
      (this == AppBarLeadingType.drawerOrRail && !AppUtils.isMobile());
}

PlatformAppBar buildAppBar({
  required String title,
  Widget? titleWidget,
  AppBarLeadingType leading = AppBarLeadingType.drawer,
  Widget? leadingWidget,
  List<Widget>? actions,
  bool showTrailingLogo = true,
  required BuildContext context,
  double? titleSpacing,
}) {
  return PlatformAppBar(
    automaticallyImplyLeading: false,
    leading: leadingWidget ?? leading.buildWidget(context),
    trailingActions: actions,
    title: titleWidget ??
        CustomText(
          title,
          fontSize: 16,
          color: context.colors.onAppBar,
        ),
    backgroundColor: context.colors.appBar,
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: true,
      toolbarHeight: dimens.appBarHeight,
      titleSpacing: titleSpacing,
      scrolledUnderElevation: kIsWeb ? 0 : null,
      backgroundColor: context.colors.appBar,
      elevation: kIsWeb ? 0 : null,
    ),
    cupertino: (ctx, __) => CupertinoNavigationBarData(
      // Issue with cupertino where a bar with no transparency
      // will push the list down. Adding some alpha value fixes it (in a hacky way)
      backgroundColor: context.colors.appBar.withValues(alpha: .99),
      automaticBackgroundVisibility: false,
    ),
  );
}
