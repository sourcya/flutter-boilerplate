part of '../../ui.dart';

enum AppBarLeadingType {
  none,
  back,
  logoIcon,
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
                color: context.colors.onSurface,
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
      case AppBarLeadingType.logoIcon:
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.r),
          height: kToolbarHeight - (PlayxPlatform.isIOS ? 16 : 4),
          child: ImageViewer.svgAsset(
            Assets.icons.logo,
            height: kToolbarHeight - (PlayxPlatform.isIOS ? 24 : 4),
            color: context.colors.onAppBar,
          ),
        );
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
  String? title,
  Widget? titleWidget,
  AppBarLeadingType leadingType = AppBarLeadingType.drawer,
  Widget? leadingWidget,
  List<Widget>? actions,
  bool showTrailingLogo = true,
  required BuildContext context,
  double? titleSpacing,
  Color? backgroundColor,
  bool? enableBackgroundFilterBlur,
}) {
  return PlatformAppBar(
    automaticallyImplyLeading: false,
    leading: leadingWidget ?? leadingType.buildWidget(context),
    trailingActions: actions,
    title: titleWidget ??
        (title != null
            ? CustomText(
                title,
                fontSize: 16,
                color: context.colors.onAppBar,
              )
            : null),
    backgroundColor: backgroundColor ?? context.colors.appBar,
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: true,
      toolbarHeight: dimens.appBarHeight,
      titleSpacing: titleSpacing ??
          (leadingType == AppBarLeadingType.logoIcon ? 0 : null),
      backgroundColor: backgroundColor ?? context.colors.appBar,
      leadingWidth:
          leadingType == AppBarLeadingType.logoIcon ? ctx.width * 0.25 : null,
      // scrolledUnderElevation: kIsWeb ? 0 : null,
      // elevation: kIsWeb ? 0 : null,
      scrolledUnderElevation: 0,
      elevation: 0,
    ),
    cupertino: (ctx, __) => CupertinoNavigationBarData(
      // Issue with cupertino where a bar with no transparency
      // will push the list down. Adding some alpha value fixes it (in a hacky way)
      backgroundColor:
          backgroundColor ?? context.colors.appBar.withValues(alpha: .99),
      automaticBackgroundVisibility: false,
      enableBackgroundFilterBlur: enableBackgroundFilterBlur,
    ),
  );
}
