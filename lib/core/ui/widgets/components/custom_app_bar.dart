part of '../../ui.dart';

class BreadcrumbItem {
  final String title;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.title, this.onTap});
}

enum AppBarLeadingType {
  none,
  back,
  logoIcon,
  drawer,
  menu,
  navigationRail,
  drawerOrRail;

  Widget buildWidget(BuildContext context, {VoidCallback? onTap}) {
    switch (this) {
      case AppBarLeadingType.none:
      case AppBarLeadingType.navigationRail:
        return const SizedBox.shrink();
      case AppBarLeadingType.back:
        return AppBarIconButton(
          icon: IconInfo.svg(Assets.icons.icBackButton),
          isFlippedForRtl: true,
          onTap: () {
            if (onTap != null) {
              onTap();
            } else if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            } else {
              AppNavigation.navigateToHome();
            }
          },
        );
      case AppBarLeadingType.logoIcon:
        return Container(
          padding: context.paddingSymmetric(horizontal: 8),
          height: kToolbarHeight - (PlayxPlatform.isIOS ? 16 : 4),
          child: ImageViewer.svgAsset(
            Assets.icons.logo,
            height: kToolbarHeight - (PlayxPlatform.isIOS ? 24 : 4),
            color: context.colors.onAppBar,
          ),
        );
      case AppBarLeadingType.menu:
      case AppBarLeadingType.drawer:
      case AppBarLeadingType.drawerOrRail:
        return const MenuIconButton();
    }
  }

  bool get canShowDrawer =>
      this == AppBarLeadingType.drawer ||
      this == AppBarLeadingType.menu ||
      this == AppBarLeadingType.drawerOrRail;

  bool get canShowBack => this == AppBarLeadingType.back;
}

List<Widget> buildAppBarTrailingActions({
  required BuildContext context,
  List<Widget>? actions,
  bool showNotificationButton = false,
  required bool supportVisible,
  bool compactSpacing = false,
}) {
  return [
    ...(actions ?? []),
    if (showNotificationButton) ...[
      8.wBox,
    ],
    if (supportVisible) const SupportButton(size: 32),
  ];
}

Widget buildAppBarTitle({
  required BuildContext context,
  String? title,
  Widget? titleWidget,
  List<BreadcrumbItem>? breadcrumbs,
  required bool includeBreadcrumb,
  bool isLandscapeStyle = false,
}) {
  if (includeBreadcrumb) {
    return BreadcrumbHeader(items: breadcrumbs ?? []);
  }
  if (titleWidget != null) {
    return titleWidget;
  }
  return CustomText(
    title ?? '',
    fontSize: isLandscapeStyle ? 16.0.sp : 14.0.sp,
    isResponsive: false,
    color: context.colors.foreground,
    fontWeight: FontWeight.w600,
    height: isLandscapeStyle ? 1.50 : 1,
    letterSpacing: isLandscapeStyle ? null : -0.45,
    font: fontFamilyBasedOnText(title ?? ''),
  );
}

class LandscapeAppBar extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final List<Widget>? actions;
  final List<BreadcrumbItem>? breadcrumbs;
  final bool? attachBreadcrumb;
  final bool showSupportButton;
  final bool showNotificationButton;
  final bool? showWhatsAppSupport;

  const LandscapeAppBar({
    super.key,
    this.title,
    this.titleWidget,
    this.actions,
    this.breadcrumbs,
    this.attachBreadcrumb,
    this.showSupportButton = true,
    this.showNotificationButton = false,
    this.showWhatsAppSupport,
  });

  @override
  Widget build(BuildContext context) {
    final includeBreadcrumb =
        (attachBreadcrumb ?? true) && breadcrumbs?.isNotEmpty == true;
    final supportVisible = showWhatsAppSupport ?? showSupportButton;

    return Container(
      padding: EdgeInsetsDirectional.only(
        top: 8.0.r,
        start: 24.0.r,
        end: 16.0.r,
        bottom: 8.0.r,
      ),
      color: context.colors.background,
      child: Row(
        children: [
          Expanded(
            child: buildAppBarTitle(
              context: context,
              title: title,
              titleWidget: titleWidget,
              breadcrumbs: breadcrumbs,
              includeBreadcrumb: includeBreadcrumb,
              isLandscapeStyle: true,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: buildAppBarTrailingActions(
              context: context,
              actions: actions,
              showNotificationButton: showNotificationButton,
              supportVisible: supportVisible,
              compactSpacing: true,
            ),
          ),
        ],
      ),
    );
  }
}

PlatformAppBar buildAppBar({
  required BuildContext context,
  String? title,
  Widget? titleWidget,
  AppBarLeadingType leading = AppBarLeadingType.drawer,
  AppBarLeadingType leadingType = AppBarLeadingType.drawer,
  Widget? leadingWidget,
  Widget? headerLeadingWidget,
  List<Widget>? actions,
  double? titleSpacing,
  PreferredSizeWidget? bottom,
  List<BreadcrumbItem>? breadcrumbs,
  bool? attachBreadcrumb,
  VoidCallback? onBackPressed,
  Color? backgroundColor,
  bool? enableBackgroundFilterBlur,
  bool showTrailingLogo = true,
  bool showSupportButton = true,
  bool showNotificationButton = false,
  bool? showWhatsAppSupport,
  bool showUserAvatar = false,
  bool isWideWeb = false,
  bool showLeading = true,
}) {
  final supportVisible = showWhatsAppSupport ?? showSupportButton;
  final resolvedLeadingWidget = headerLeadingWidget ?? leadingWidget;
  final includeBreadcrumb =
      (attachBreadcrumb ?? context.isAppLandscape) &&
      breadcrumbs?.isNotEmpty == true;
  final appBarBackground = backgroundColor ??
      (context.isAppPortrait ? context.colors.appBar : context.colors.surface);

  return PlatformAppBar(
    automaticallyImplyLeading: false,
    leading: !showLeading
        ? null
        : MediaQuery.removePadding(
            context: context,
            removeLeft: true,
            removeRight: true,
            child: resolvedLeadingWidget ??
                (includeBreadcrumb
                    ? AppBarLeadingType.drawer.buildWidget(context)
                    : leading.buildWidget(context, onTap: onBackPressed)),
          ),
    trailingActions: buildAppBarTrailingActions(
      context: context,
      actions: actions,
      showNotificationButton: showNotificationButton,
      supportVisible: supportVisible,
    ),
    title: Row(
      children: [
        Expanded(
          child: buildAppBarTitle(
            context: context,
            title: title,
            titleWidget: titleWidget,
            breadcrumbs: breadcrumbs,
            includeBreadcrumb: includeBreadcrumb,
          ),
        ),
      ],
    ),
    backgroundColor: appBarBackground,
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: false,
      toolbarHeight: isWideWeb ? 48.r : dimens.appBarHeight,
      titleSpacing: titleSpacing ?? 0,
      scrolledUnderElevation: 0,
      backgroundColor: appBarBackground,
      elevation: 0,
      bottom: bottom,
    ),
    cupertino: (ctx, _) => CupertinoNavigationBarData(
      backgroundColor: appBarBackground.withValues(alpha: .99),
      automaticBackgroundVisibility: false,
      enableBackgroundFilterBlur: enableBackgroundFilterBlur,
      bottom: bottom,
    ),
  );
}

class BreadcrumbHeader extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const BreadcrumbHeader({required this.items});

  @override
  Widget build(BuildContext context) {
    final displayItems = items.length > 4
        ? <BreadcrumbItem>[
            items.first,
            BreadcrumbItem(title: '...'),
            ...items.sublist(items.length - 3),
          ]
        : items;

    return Material(
      type: MaterialType.transparency,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.r,
          children: displayItems.asMap().entries.map((entry) {
            final int idx = entry.key;
            final BreadcrumbItem item = entry.value;
            final bool isLast = idx == displayItems.length - 1;
            final bool isEllipsis = item.title == '...';

            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: isLast || isEllipsis ? null : item.onTap,
                  borderRadius: BorderRadius.circular(4.r),
                  child: Padding(
                    padding: context.paddingSymmetric(horizontal: 2.0, vertical: 4.0),
                    child: CustomText(
                      item.title,
                      fontSize: 14.sp,
                      isResponsive: false,
                      color: isLast
                          ? context.colors.foreground
                          : context.colors.mutedForeground,
                      fontWeight: FontWeight.w400,
                      height: isLast ? 1.71 : 1.43,
                    ),
                  ),
                ),
                if (!isLast)
                  Padding(
                    padding: context.paddingSymmetric(horizontal: 4.0),
                    child: Icon(
                      context.isLtr ? Icons.chevron_right : Icons.chevron_left,
                      size: 16.r,
                      color: context.colors.mutedForeground,
                    ),
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
