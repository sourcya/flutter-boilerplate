part of '../../imports/app_imports.dart';

mixin AppDrawerMixin on GetxController {
  AppController get app => this as AppController;

  final isDrawerExpanded = true.obs;
  final GlobalKey<ScaffoldState> shellScaffoldKey = GlobalKey<ScaffoldState>();
  final AdvancedDrawerController drawerController = AdvancedDrawerController();
  final RxBool disableDrawerGestures = true.obs;
  final RxInt currentDrawerIndex = RxInt(0);

  late final mainDrawerItems = RxList<CustomNavigationDestinationItem>.from(
    app.drawerNavItems,
  );
  late final moduleDrawerItems = RxList<CustomNavigationDestinationItem>();

  List<CustomNavigationDestinationItem> get allModuleDrawerItems => [
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.icTable),
      label: AppTrans.reportsModuleTitle,
      navigationIndex: 2,
      route: Routes.reports,
      module: const DrawerAppModule(AppModules.reports),
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.icLayoutGrid),
      label: AppTrans.analyticsModuleTitle,
      navigationIndex: 3,
      route: Routes.analytics,
      module: const DrawerAppModule(AppModules.analytics),
    ),
  ];

  int currentBottomNavIndex = 0;
  final showBottomNav = true.obs;

  late final List<CustomNavigationDestinationItem> bottomNavItems = [];

  ValueListenable<AdvancedDrawerValue> get drawerStateListenable => drawerController;
  bool get isDrawerVisible => isDrawerExpanded.value;

  void initDrawerState() {
    drawerController
      ..removeListener(_syncDrawerState)
      ..addListener(_syncDrawerState);
    _syncDrawerState();
  }

  set drawerIndex(int index) => currentDrawerIndex.value = index;

  void disposeDrawerState() {
    drawerController.removeListener(_syncDrawerState);
  }

  void _syncDrawerState() {
    final visible = drawerController.value.visible;
    if (isDrawerExpanded.value != visible) {
      isDrawerExpanded.value = visible;
    }
  }

  bool isDrawerOpen() => drawerController.value.visible;

  Future<void> openDrawer() async => drawerController.showDrawer();

  Future<void> closeDrawer() async => drawerController.hideDrawer();

  void toggleDrawer() {
    if (isDrawerOpen()) {
      unawaited(closeDrawer());
    } else {
      unawaited(openDrawer());
    }
  }

  void handleDrawerMainItemClicked({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    handleDrawerNavigation(
      navigationShell: navigationShell,
      navigationIndex: index,
    );
  }

  void handleDrawerItemTap({
    required CustomNavigationDestinationItem item,
    required StatefulNavigationShell navigationShell,
  }) {
    handleDrawerNavigation(
      navigationShell: navigationShell,
      navigationIndex: item.navigationIndex,
      route: item.navigationIndex == null ? item.route : null,
    );
  }

  void handleDrawerNavigation({
    required StatefulNavigationShell navigationShell,
    int? navigationIndex,
    String? route,
  }) {
    if (navigationIndex != null && currentDrawerIndex.value != navigationIndex) {
      currentDrawerIndex.value = navigationIndex;
      PlayxNavigation.goToBranch(
        index: navigationIndex,
        navigationShell: navigationShell,
        initialLocation: true,
      );
    } else if (navigationIndex != null) {
      currentDrawerIndex.value = navigationIndex;
    }
    if (route != null) {
      PlayxNavigation.offAllNamed(route);
    }
    _closePortraitDrawer();
  }

  bool isSubItemSelected(CustomNavigationSubItem sub) {
    if (sub.route != null && PlayxNavigation.currentRouteName == sub.route) {
      if (sub.queryTab == null || sub.queryTab!.isEmpty) return true;
      final tab = _currentQueryTab();
      return tab == sub.queryTab || (tab == null && sub.queryTab == SettingsTabs.account.name);
    }
    return false;
  }

  bool isDrawerItemSelected(
    CustomNavigationDestinationItem item,
    StatefulNavigationShell navigationShell,
  ) {
    if (item.navigationIndex != null && item.navigationIndex == navigationShell.currentIndex) {
      return true;
    }
    if (item.isExpandable) {
      return item.subItems.any(isSubItemSelected);
    }
    if (item.navigationIndex != null && item.navigationIndex == currentDrawerIndex.value) {
      return true;
    }
    return item.route != null && PlayxNavigation.currentRouteName == item.route;
  }

  void handleDrawerSubItemTap({
    required CustomNavigationSubItem subItem,
    required StatefulNavigationShell navigationShell,
  }) {
    if (subItem.onTap != null) {
      if (subItem.navigationIndex != null) {
        currentDrawerIndex.value = subItem.navigationIndex!;
      }
      subItem.onTap!();
      _closePortraitDrawer();
      return;
    }
    handleDrawerNavigation(
      navigationShell: navigationShell,
      navigationIndex: subItem.navigationIndex,
      route: subItem.route,
    );
  }

  void handleDrawerSubItemTapFromUi({
    required CustomNavigationSubItem subItem,
    required StatefulNavigationShell navigationShell,
  }) {
    handleDrawerSubItemTap(subItem: subItem, navigationShell: navigationShell);
    mainDrawerItems.refresh();
    HapticFeedback.selectionClick();
  }

  void openDrawerCollapsedItemMenu({
    required BuildContext anchorContext,
    required CustomNavigationDestinationItem item,
    required StatefulNavigationShell navigationShell,
  }) {
    showDrawerSubItemsSubmenu(
      anchorContext,
      headerTitle: item.label,
      entries: [
        for (final sub in item.subItems)
          (
            label: sub.label,
            isSelected: isSubItemSelected(sub),
            onTap: () => handleDrawerSubItemTapFromUi(
              subItem: sub,
              navigationShell: navigationShell,
            ),
          ),
      ],
    );
  }

  String? _currentQueryTab() {
    final ctx = NavigationUtils.navigationContext;
    if (ctx == null) return null;
    try {
      return GoRouterState.of(ctx).uri.queryParameters['tab'];
    } catch (_) {
      return null;
    }
  }

  void _closePortraitDrawer() {
    final ctx = NavigationUtils.navigationContext;
    if (ctx != null && ctx.isAppPortrait && isDrawerOpen()) {
      unawaited(closeDrawer());
    }
  }

  void handleDrawerOtherItemClicked({
    required int index,
    required BuildContext context,
  }) {
    switch (index) {
      case 0:
        navigateToSupport(context: context);
      case 1:
        unawaited(app.handleLogout(context: context));
    }
  }

  PlayxThemeClipperAnimation _themeClipperAnimation() {
    return PlayxThemeClipperAnimation(
      context: NavigationUtils.navigationContext,
    );
  }

  void _scheduleThemeChange(VoidCallback changeTheme) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) => changeTheme());
    });
  }

  Future<void> _dismissOverlaysThenApplyTheme(VoidCallback applyTheme) async {
    await closeDrawer();
    _scheduleThemeChange(applyTheme);
  }

  Future<void> handleProfileLanguageTap(BuildContext context) async {
    await DrawerProfileLanguagePickerSheet.show(context);
    unawaited(closeDrawer());
  }

  Future<void> navigateToSupport({required BuildContext context}) async {
    unawaited(contactSupportViaWhatsapp(context: context));
    await closeDrawer();
  }

  set bottomNavIndex(int index) => currentBottomNavIndex = index;

  void handleBottomNavItemChanged({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    PlayxNavigation.goToBranch(index: index, navigationShell: navigationShell);
  }

  String getUserDisplayName(
    BuildContext context, {
    UserInfo? user,
    Subscription? subscription,
  }) {
    final fullName = user?.getFullName()?.trim();
    if (fullName != null && fullName.isNotEmpty) {
      return fullName;
    }
    return '—';
  }

  String getUserDisplayEmail({
    UserInfo? user,
    Subscription? subscription,
  }) {
    return user?.email ?? '';
  }

  Future<void> onUserProfileTap({
    required BuildContext context,
    UserInfo? user,
    Subscription? sub,
  }) async {
    final resolvedUser = user ?? app.currentUser.value;
    final name = getUserDisplayName(context, user: resolvedUser, subscription: sub);
    final email = getUserDisplayEmail(user: resolvedUser, subscription: sub);
    final isDark = context.isDarkMode;
    final isLandscape = context.isAppLandscape;
    final useCupertinoProfileSheet =
        PlayxPlatform.isCupertino && context.isMobile && context.isAppPortrait;

    if (useCupertinoProfileSheet) {
      await showCupertinoModalPopup<void>(
        context: context,
        builder: (sheetContext) => CupertinoTheme(
          data: CupertinoThemeData(
            brightness: isDark ? Brightness.dark : Brightness.light,
          ),
          child: CupertinoActionSheet(
            title: DrawerProfileUserHeader(
              name: name.isEmpty ? '—' : name,
              email: email,
              isLandscape: isLandscape,
            ),
            actions: [
              ...SettingsTabs.visibleTabs.map(
                (tab) => CupertinoActionSheetAction(
                  onPressed: () {
                    Navigator.of(sheetContext).pop();
                    handleProfileSettingsTabTap(tab);
                  },
                  child: Padding(
                    padding: sheetContext.paddingSymmetric(horizontal: 8),
                    child: Row(
                      children: [
                        ImageViewer.svgAsset(
                          tab.iconAsset,
                          width: 16.r,
                          height: 16.r,
                          color: sheetContext.colors.onSurface,
                        ),
                        8.wBox,
                        Expanded(child: CustomText(tab.title)),
                      ],
                    ),
                  ),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  unawaited(
                    _dismissOverlaysThenApplyTheme(() {
                      PlayxTheme.next(animation: _themeClipperAnimation());
                    }),
                  );
                },
                child: Padding(
                  padding: sheetContext.paddingSymmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IconInfo.svg(
                        isDark ? Assets.icons.icLightMode : Assets.icons.icDarkMode,
                      ).buildIconWidget(
                        color: sheetContext.colors.onSurface,
                        size: 16.r,
                      ),
                      8.wBox,
                      Expanded(
                        child: CustomText(
                          isDark ? AppTrans.lightTheme : AppTrans.darkTheme,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  unawaited(handleProfileLanguageTap(context));
                },
                child: Padding(
                  padding: sheetContext.paddingSymmetric(horizontal: 8),
                  child: Row(
                    children: [
                      ImageViewer.svgAsset(
                        Assets.icons.icLanguage,
                        width: 16.r,
                        height: 16.r,
                        color: sheetContext.colors.onSurface,
                      ),
                      8.wBox,
                      const Expanded(child: CustomText(AppTrans.language)),
                    ],
                  ),
                ),
              ),
              CupertinoActionSheetAction(
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(sheetContext).pop();
                  handleProfileLogoutTap(context);
                },
                child: Padding(
                  padding: sheetContext.paddingSymmetric(horizontal: 8),
                  child: Row(
                    children: [
                      IconInfo.svg(Asset.icons.icLogout).buildIconWidget(
                        size: 16.r,
                        color: sheetContext.colors.error,
                      ),
                      8.wBox,
                      const Expanded(child: CustomText(AppTrans.logout)),
                    ],
                  ),
                ),
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
              onPressed: () => Navigator.of(sheetContext).pop(),
              child: const CustomText(AppTrans.cancel),
            ),
          ),
        ),
      );
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    final screenSize = context.mediaQuery.size;
    final isLTR = context.isLtr;
    final double menuWidth = context.isAppLandscape ? 224.0 : 224.0.r;
    final double menuCornerRadius = context.isAppLandscape ? 12.0 : 12.0.r;
    final double gap = 8.r;
    const double sideMargin = 8.0;
    final double verticalOffset = 4.r;

    double left;
    if (isLTR) {
      left = position.dx + size.width + gap;
      if (left + menuWidth + sideMargin > screenSize.width) {
        left = (screenSize.width - sideMargin - menuWidth).clamp(
          sideMargin,
          screenSize.width - sideMargin,
        );
      }
    } else {
      left = position.dx - menuWidth - gap;
      if (left < sideMargin) {
        left = sideMargin;
      }
    }

    final double top = position.dy + size.height + verticalOffset;
    final double bottom = (screenSize.height - top).clamp(0.0, screenSize.height);
    final double right = (screenSize.width - (left + menuWidth)).clamp(
      0.0,
      screenSize.width,
    );

    await showMenu<void>(
      context: context,
      position: RelativeRect.fromLTRB(
        left,
        top,
        math.max(0.0, right),
        bottom,
      ),
      elevation: 0,
      color: AppColors.transparent,
      shadowColor: AppColors.transparent,
      surfaceTintColor: AppColors.transparent,
      menuPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(menuCornerRadius),
      ),
      constraints: BoxConstraints(minWidth: menuWidth, maxWidth: menuWidth),
      items: <PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          enabled: false,
          height: 0,
          padding: EdgeInsets.zero,
          child: DrawerMaterialProfileMenuContent(
            anchorContext: context,
            userHeader: DrawerProfileUserHeader(
              name: name.isEmpty ? '—' : name,
              email: email,
              isLandscape: isLandscape,
            ),
            isLandscape: isLandscape,
          ),
        ),
      ],
    );
  }

  void handleProfileLogoutTap(BuildContext context) {
    unawaited(app.handleLogout(context: context));
  }

  void handleProfileSettingsTabTap(SettingsTabs tab) {
    unawaited(closeDrawer());
    AppNavigation.navigateToSettings(tab: tab);
  }

  void handleProfileThemeApply(XTheme theme, BuildContext anchorContext) {
    unawaited(
      _dismissOverlaysThenApplyTheme(() {
        PlayxTheme.updateTo(theme, animation: _themeClipperAnimation());
      }),
    );
  }

  Future<void> handleProfileLanguageApply(
    XLocale locale,
    BuildContext anchorContext,
  ) async {
    unawaited(closeDrawer());
    await WidgetsBinding.instance.endOfFrame;
    await PlayxLocalization.updateTo(locale, forceAppUpdate: true);
  }
}
