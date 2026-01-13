part of '../../ui.dart';

// 1. Data model for a single breadcrumb item
class BreadcrumbItem {
  final String title;
  final VoidCallback? onTap;

  BreadcrumbItem({required this.title, this.onTap});
}

enum AppBarLeadingType {
  none,
  back,
  drawer;

  Widget buildWidget(BuildContext context) {
    switch (this) {
      case AppBarLeadingType.none:
        return const SizedBox.shrink();
      case AppBarLeadingType.back:
        return kIsWeb
            ? const MenuIconButton()
            : Builder(
                builder: (context) {
                  return IconButton(
                    icon: Icon(
                      PlayxPlatform.isIOS
                          ? CupertinoIcons.back
                          : Icons.arrow_back,
                      color: context.colors.onAppBar,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  );
                },
              );
      case AppBarLeadingType.drawer:
        return const MenuIconButton();
    }
  }

  bool get canShowDrawer => this == AppBarLeadingType.drawer;
  bool get canShowBack => this == AppBarLeadingType.back;
}

PlatformAppBar buildAppBar({
  required BuildContext context,
  String? title,
  Widget? titleWidget,
  AppBarLeadingType leading = AppBarLeadingType.drawer,
  Widget? leadingWidget,
  List<Widget>? actions,
  bool showTrailingLogo = true,
  double? titleSpacing,
  PreferredSizeWidget? bottom,
  List<BreadcrumbItem>? breadcrumbs,
  bool? attachBreadcrumb,
  bool? showWhatsAppSupport,
}) {
  final includeBreadcrumb = (attachBreadcrumb ?? context.isLandscape) &&
      breadcrumbs?.isNotEmpty == true;
  return PlatformAppBar(
    automaticallyImplyLeading: false,
    leading: MediaQuery.removePadding(
      context: context,
      removeLeft: true,
      removeRight: true,
      child: leadingWidget ??
          (includeBreadcrumb
              ? AppBarLeadingType.drawer.buildWidget(context)
              : leading.buildWidget(context)),
    ),
    trailingActions: [
      ...(actions ?? []),
      // Show logo and support button
      if (showWhatsAppSupport ??
          NavigationUtils.canShowDrawer || includeBreadcrumb)
        Padding(
          padding:
              EdgeInsets.symmetric(horizontal: PlayxPlatform.isIOS ? 0 : 8.r),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SupportButton(size: 32),
            ],
          ),
        ),
    ],
    title: Row(
      children: [
        // 3. The Vertical Divider (matches image)
        SizedBox(
          height: (context.isMobile ? kToolbarHeight: kToolbarHeight.r) - 20.r,
          child: VerticalDivider(
            color: context.colors.borderColor,
            thickness: 1.r,
            endIndent: 5.r,
            indent: 5.r,
            width: 1.r,
          ),
        ),
        SizedBox(width: 12.r),

        // 4. Render Breadcrumbs OR Title
        Expanded(
          child: includeBreadcrumb
              ? BreadcrumbHeader(items: breadcrumbs ?? [])
              : titleWidget ??
                  CustomText(
                    title ?? '',
                    fontSize: context.isMobile ? 16 : 16.sp,
                    color: context.colors.onAppBar,
                    fontWeight: FontWeight.w400,
                    font: fontFamilyBasedOnText(title ?? ''),
                  ),
        ),
      ],
    ),
    backgroundColor: context.colors.appBar,
    bottom: bottom,
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: false,
      titleSpacing: titleSpacing ?? 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.appBar,
      elevation: 0,
      bottom: bottom,
    ),
    cupertino: (ctx, _) => CupertinoNavigationBarData(
      backgroundColor: context.colors.appBar.withValues(alpha: .99),
      automaticBackgroundVisibility: false,
      bottom: bottom,
      padding: context.isLandscape && context.isMobile
          ? EdgeInsetsDirectional.zero
          : null,
      // enableBackgroundFilterBlur: true,
    ),
  );
}

// 5. The Breadcrumb Widget Logic
class BreadcrumbHeader extends StatelessWidget {
  final List<BreadcrumbItem> items;

  const BreadcrumbHeader({required this.items});

  @override
  Widget build(BuildContext context) {
    // Logic to handle "..." if list is too long (e.g., > 4 items)
    // Matches the "Home > ... > Components" style in your image
    List<BreadcrumbItem> displayItems = [];
    if (items.length > 4) {
      displayItems = [
        items.first, // Home
        BreadcrumbItem(title: '...'), // Ellipsis
        ...items.sublist(items.length - 3), // Last 3 items
      ];
    } else {
      displayItems = items;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: displayItems.asMap().entries.map((entry) {
          final int idx = entry.key;
          final BreadcrumbItem item = entry.value;
          final bool isLast = idx == displayItems.length - 1;
          final bool isEllipsis = item.title == '...';

          return Row(
            children: [
              // The Text Item
              InkWell(
                onTap: isLast || isEllipsis ? null : item.onTap,
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.r, vertical: 4.r),
                  child: CustomText(
                    item.title,
                    fontSize: 14.sp,
                    color: isLast
                        ? (context.colors.onSurface)
                        : (context.colors.subtitleTextColor),
                    fontWeight: isLast ? FontWeight.w500 : FontWeight.w400,
                  ),
                ),
              ),
              // The Separator (Chevron)
              if (!isLast)
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.r),
                  child: Icon(
                    Icons.keyboard_arrow_right,
                    size: 16.r,
                    color: context.colors.subtitleTextColor,
                  ),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
