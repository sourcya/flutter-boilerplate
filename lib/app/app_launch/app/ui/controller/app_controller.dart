part of '../imports/app_imports.dart';

class AppController extends SuperController {
  final AuthRepository _authRepository;
  final AppRepository _repository;
  AppController({
    required AuthRepository authRepository,
    AppRepository? repository,
  }) : _authRepository = authRepository,
       _repository = repository ?? AppRepository.instance;

  static AppController get instance => getIt.get<AppController>();

  final isDrawerExpanded = true.obs;

  final loadingStatus = Rx(const LoadingStatus.idle());

  final AdvancedDrawerController drawerController = AdvancedDrawerController();

  final RxBool disableDrawerGestures = true.obs;

  final RxInt currentDrawerIndex = RxInt(0);
  final RxInt currentModuleDrawerIndex = RxInt(0);

  final RxBool showVersionCode = RxBool(false);
  late final mainDrawerItems = RxList<CustomNavigationDestinationItem>.from(
    _repository.mainDrawerItems,
  );

  late final moduleDrawerItems = RxList<CustomNavigationDestinationItem>();
  late final otherDrawerItems = _repository.otherDrawerItems;

  final Rxn<UserInfo> currentUser = Rxn<UserInfo>();

  Completer<void> appInitializationCompleter = Completer<void>();
  int currentBottomNavIndex = 0;

  final showBottomNav = true.obs;

  late final List<CustomNavigationDestinationItem> bottomNavItems = [
    CustomNavigationDestinationItem(
      icon: IconInfo(
        icon: Icons.home_outlined,
      ),
      label: AppTrans.home,
      navigationIndex: 0,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(
        icon: Icons.favorite_border,
      ),
      label: AppTrans.wishlist,
      navigationIndex: 1,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo(
        icon: Icons.settings,
      ),
      label: AppTrans.settings,
      navigationIndex: 2,
    ),
  ];
  @override
  void onInit() {
    super.onInit();
    setupSettings();
    updateCurrentUser();
  }

  Future<void> setupSettings() async {
    try {
      showVersionCode.value = await EnvManger.instance.showVersionCode;
      if (!appInitializationCompleter.isCompleted) {
        appInitializationCompleter.complete();
      }
    } catch (e) {
      myLogger.e('Error in setupSettings', error: e);
    }
  }

  Future<void> updateCurrentUser({UserInfo? user}) async {
    final currentUser =
        user ?? await MyPreferenceManger.instance.getSavedUser();
    if (currentUser != null) {
      this.currentUser.value = currentUser;
    }
  }

  Future<UserInfo?> getCurrentUser() async {
    if (currentUser.value == null) {
      await updateCurrentUser();
    }
    return currentUser.value;
  }

  Future<void> logout({
    bool shouldNavigateToLogin = true,
    BuildContext? context,
    bool showConfirmation = true,
  }) async {
    final logoutContext = context ?? NavigationUtils.navigationContext;
    if (!showConfirmation || logoutContext == null) {
      _logout(shouldNavigateToLogin: shouldNavigateToLogin);
      return;
    }

    final isConfirmed = await showConfirmDialog(
      title: AppTrans.logoutDialogTitle.tr(),
      message: AppTrans.logoutDialogMessage.tr(),
      lottie: Assets.animations.logout,
      onConfirmed: () {},
      context: logoutContext,
    );
    if (isConfirmed) {
      _logout(shouldNavigateToLogin: shouldNavigateToLogin);
    }
  }

  Future<void> _logout({required bool shouldNavigateToLogin}) async {
    closeDrawer();
    loadingStatus.value = const LoadingStatus.logout();
    try {
      await AuthRepository.handleSignOut();
    }
    // ignore: avoid_catches_without_on_clauses
    catch (e, s) {
      Sentry.captureException(e, stackTrace: s);
    }

    currentUser.value = null;
    if (shouldNavigateToLogin) {
      // final loginType = await getLoginViewType();
      loadingStatus.value = const LoadingStatus.idle();
      Future.delayed(200.milliseconds);
      AppNavigation.navigateToLogin();
    } else {
      loadingStatus.value = const LoadingStatus.idle();
    }
  }

  // Future<LoginViewType> getLoginViewType() async {
  //   final canAuthenticateWithBiometric =
  //       await _authRepository.canAuthenticateWithBiometric();
  //   return canAuthenticateWithBiometric
  //       ? LoginViewType.biometric
  //       : LoginViewType.login;
  // }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {}

  Future<void> handleDrawerMainItemClicked({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) async {
    if (index == currentDrawerIndex.value) return;
    currentDrawerIndex.value = index;
    PlayxNavigation.goToBranch(
      index: index,
      navigationShell: navigationShell,
      initialLocation: true,
    );
    if (isDrawerOpen()) {
      closeDrawer();
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
        logout(context: context);
    }
  }

  Future<void> navigateToSupport({required BuildContext context}) async {
    contactSupportViaWhatsapp(context: context);
    closeDrawer();
  }

  bool isDrawerOpen() => drawerController.value.visible;

  Future<void> openDrawer() async {
    return drawerController.showDrawer();
  }

  Future<void> closeDrawer() async {
    return drawerController.hideDrawer();
  }

  void toggleDrawer() {
    if (isDrawerOpen()) {
      closeDrawer();
    } else {
      openDrawer();
    }
  }

  // void _startTrackUsageTimer() {
  //   _trackUsageTimer?.cancel();
  //   _trackUsageTimer = Timer.periodic(1.minutes, (_) {
  //     MyPreferenceManger.instance.incrementTrackUserAppUsageTime(
  //       const Duration(minutes: 1),
  //     );
  //     // _printTrackUsage();
  //   });
  // }

  // Future<void> _printTrackUsage() async {
  //   final appUsageTime =
  //       await MyPreferenceManger.instance.getTrackUserAppUsageTime();
  //   talker.verbose('App Usage Time: ${appUsageTime.inMinutes} minutes');
  // }

  // Future<void> checkInAppReview() async {
  //   if (kIsWeb) return;
  //   final isInAppReviewDialogShownCount =
  //   await MyPreferenceManger.instance.inAppReviewDialogShowCount;
  //   if (isInAppReviewDialogShownCount > 1) return;
  //   final appUsageTime = await MyPreferenceManger.instance.getTrackUserAppUsageTime();
  //   try {
  //     if (appUsageTime.inMinutes >= 20 && isInAppReviewDialogShownCount == 0 ||
  //         appUsageTime.inMinutes >= 60 && isInAppReviewDialogShownCount == 1) {
  //       final InAppReview inAppReview = InAppReview.instance;
  //
  //       if (await inAppReview.isAvailable()) {
  //         await inAppReview.requestReview();
  //         await MyPreferenceManger.instance.incrementInAppReviewDialogShowCount();
  //       }
  //     }
  //   } catch (e) {
  //     Sentry.captureException(e);
  //   }
  // }

  void handleDrawerModuleItemClicked({
    required int index,
    required StatefulNavigationShell navigationShell,
    required CustomNavigationDestinationItem item,
  }) {
    if (item.navigationIndex == currentDrawerIndex.value) return;
    currentDrawerIndex.value = mainDrawerItems.length + index;
    PlayxNavigation.goToBranch(
      index: item.navigationIndex ?? index,
      navigationShell: navigationShell,
      initialLocation: true,
    );
    if (isDrawerOpen()) {
      closeDrawer();
    }
  }

  void updateBottomNavIndex(int index) {
    if (index < 3) {
      currentBottomNavIndex = index;
    } else if (index < 0) {
      currentBottomNavIndex = 0;
    }
  }

  void handleBottomNavItemChanged({
    required int index,
    required StatefulNavigationShell navigationShell,
  }) {
    PlayxNavigation.goToBranch(index: index, navigationShell: navigationShell);
  }

  Future<void> onUserProfileTap({
    required BuildContext context,
    UserInfo? user,
  }) async {
    final userName = (user?.getFullName(fallbackAsEmail: false) ?? "")
        .capitalizeFirstCharForEachWord;
    final isDark = context.isDarkMode;

    // Helper widget to ensure Header looks identical in both styles
    Widget buildUserHeader(BuildContext ctx) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.r),
        child: Row(
          children: [
            Container(
              width: 32.0.r,
              height: 32.0.r,
              decoration: ShapeDecoration(
                color: ctx.colors.primaryContainer,
                shape: const CircleBorder(),
              ),
              child: Icon(
                Icons.person,
                size: 16.0.r,
                color: ctx.colors.onPrimaryContainer,
              ),
            ),
            SizedBox(width: 8.r),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    userName,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: ctx.colors.onSurface,
                  ),
                  // if (sub?.privileges.displayName != null) ...[
                  //   4.boxR,
                  //   CustomText(
                  //     sub!.privileges.displayName,
                  //     fontSize: 12.sp,
                  //     fontWeight: FontWeight.w400,
                  //     color: ctx.colors.subtitleTextColor,
                  //     maxLines: 1,
                  //     textOverflow: TextOverflow.ellipsis,
                  //   ),
                  // ],
                ],
              ),
            ),
          ],
        ),
      );
    }

    if (PlayxPlatform.isCupertino) {
      // --- CUPERTINO STYLE ---
      showCupertinoModalPopup(
        context: context,
        builder: (ctx) => CupertinoTheme(
          data: const CupertinoThemeData().copyWith(
            brightness: context.isDark ? Brightness.dark : Brightness.light,
          ),
          child: PlayxThemeSwitcher(
            builder: (ctx, _) {
              return CupertinoActionSheet(
                title: buildUserHeader(ctx),
                actions: [
                  // // 1. Dynamic Items (Settings or Drawer)
                  // if (context.isLandscape)
                  //   ...SettingsTab.values.map(
                  //         (e) => CupertinoActionSheetAction(
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                  //         child: Row(
                  //           children: [
                  //             IconInfo.svg(
                  //               e.icon,
                  //               size: 16.r,
                  //               color: context.colors.onSurface,
                  //             ).buildIconWidget(),
                  //             SizedBox(width: 8.r),
                  //             Expanded(child: CustomText(e.title)),
                  //           ],
                  //         ),
                  //       ),
                  //       onPressed: () {
                  //         // Note: Using ctx here from builder
                  //         Navigator.of(ctx).pop();
                  //         closeDrawer();
                  //         AppNavigation.navigateToSettings(tab: e);
                  //       },
                  //     ),
                  //   )
                  // else ...[
                  //   ..._repository.popupDrawerItems.map(
                  //         (e) => CupertinoActionSheetAction(
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                  //         child: Row(
                  //           children: [
                  //             e.icon.buildIconWidget(
                  //               size: 16.r,
                  //               color: context.colors.onSurface,
                  //             ),
                  //             SizedBox(width: 8.r),
                  //             Expanded(child: CustomText(e.label)),
                  //           ],
                  //         ),
                  //       ),
                  //       onPressed: () {
                  //         Navigator.of(ctx).pop();
                  //         closeDrawer();
                  //         // OffAllNamed typically handles the pop, but strict parity:
                  //         PlayxNavigation.offAllNamed(e.route!);
                  //       },
                  //     ),
                  //   ),
                  // ],
                  CupertinoActionSheetAction(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                      child: Row(
                        children: [
                          Icon(
                            isDark ? Icons.light_mode : Icons.dark_mode,
                            size: 16.r,
                          ),
                          SizedBox(width: 8.r),
                          Expanded(
                            child: CustomText(
                              isDark ? AppTrans.lightTheme : AppTrans.darkTheme,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(ctx).pop();
                      await closeDrawer();

                      PlayxTheme.next(
                        animation: PlayxThemeClipperAnimation(context: ctx),
                      );
                    },
                  ),
                  // // 2. Support
                  // CupertinoActionSheetAction(
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                  //     child: Row(
                  //       children: [
                  //         IconInfo.svg(
                  //           Asset.icons.whatsappBusinessImage,
                  //           size: 16.r,
                  //         ).buildIconWidget(),
                  //         SizedBox(width: 8.r),
                  //         const Expanded(child: CustomText(AppTrans.support)),
                  //       ],
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.of(ctx).pop();
                  //     navigateToSupport(context: ctx);
                  //   },
                  // ),
                  // 3. Logout
                  CupertinoActionSheetAction(
                    isDestructiveAction: true,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0.r),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.square_arrow_left,
                            color: context.colors.error,
                          ),
                          SizedBox(width: 8.r),
                          Expanded(
                            child: CustomText(
                              AppTrans.logout,
                              color: context.colors.error,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      closeDrawer();
                      logout();
                    },
                  ),
                ],
                cancelButton: CupertinoActionSheetAction(
                  child: const CustomText(AppTrans.cancel),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              );
            },
          ),
        ),
      );
    } else {
      final renderBox = context.findRenderObject() as RenderBox?;
      if (renderBox == null) return;

      final position = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;

      final screenSize = MediaQuery.of(context).size;
      final isLTR = Directionality.of(context) == TextDirection.ltr;

      // Config
      const double maxMenuWidth = 300.0; // max menu width
      final double gap = 8.r; // horizontal gap
      const double sideMargin = 8.0; // distance from screen edges
      final double verticalOffset = 4.r; // distance below the widget

      // Horizontal placement
      final double spaceToRight =
          screenSize.width - (position.dx + size.width) - sideMargin;
      final double spaceToLeft = position.dx - sideMargin;

      double left;
      double menuWidth;

      if (isLTR) {
        menuWidth = spaceToRight > maxMenuWidth
            ? maxMenuWidth
            : spaceToRight.clamp(0.0, maxMenuWidth);
        left = position.dx + size.width + gap;

        if (left + menuWidth + sideMargin > screenSize.width) {
          left = (screenSize.width - sideMargin - menuWidth).clamp(
            sideMargin,
            screenSize.width - sideMargin,
          );
        }
      } else {
        menuWidth = spaceToLeft > maxMenuWidth
            ? maxMenuWidth
            : spaceToLeft.clamp(0.0, maxMenuWidth);
        left = position.dx - menuWidth - gap;

        if (left < sideMargin) {
          left = sideMargin;
          if (left + menuWidth + sideMargin > screenSize.width) {
            menuWidth = (screenSize.width - sideMargin * 2).clamp(
              0.0,
              maxMenuWidth,
            );
          }
        }
      }

      // Vertical placement — **below the widget**
      final double top = position.dy + size.height + verticalOffset;
      final double bottom = (screenSize.height - top).clamp(
        0.0,
        screenSize.height,
      );

      // Compute 'right' for RelativeRect
      final double right = (screenSize.width - (left + menuWidth)).clamp(
        0.0,
        screenSize.width,
      );

      // Build RelativeRect
      final RelativeRect menuPosition = RelativeRect.fromLTRB(
        left,
        top,
        right,
        bottom,
      );
      showMenu(
        context: context,
        position: menuPosition,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        color: context.colors.cardColor,
        constraints: BoxConstraints(minWidth: 250.r),
        items: <PopupMenuEntry>[
          // 1. Header
          PopupMenuItem(enabled: false, child: buildUserHeader(context)),
          const PopupMenuDivider(),

          // 2. Dynamic Items (Exactly matching Cupertino Logic)
          // if (context.isLandscape)
          //   ...SettingsTab.values.map(
          //         (e) => PopupMenuItem(
          //       // PopupMenuItem automatically pops on tap, mirroring Navigator.pop
          //       onTap: () {
          //         // Navigator.of(context).pop();
          //         closeDrawer();
          //         AppNavigation.navigateToSettings(tab: e);
          //       },
          //       child: Row(
          //         children: [
          //           IconInfo.svg(
          //             e.icon,
          //             size: 16.r,
          //             color: context.colors.onSurface,
          //           ).buildIconWidget(),
          //           SizedBox(width: 8.r),
          //           Expanded(child: CustomText(e.title)),
          //         ],
          //       ),
          //     ),
          //   )
          // else
          //   ..._repository.popupDrawerItems.map(
          //         (e) => PopupMenuItem(
          //       onTap: () {
          //         // Navigator.of(context).pop();
          //         closeDrawer();
          //         PlayxNavigation.offAllNamed(e.route!);
          //       },
          //       child: Row(
          //         children: [
          //           e.icon.buildIconWidget(
          //             size: 16.r,
          //             color: context.colors.onSurface,
          //           ),
          //           SizedBox(width: 8.r),
          //           Expanded(child: CustomText(e.label)),
          //         ],
          //       ),
          //     ),
          //   ),
          const PopupMenuDivider(),
          PopupMenuItem(
            onTap: () async {
              // Navigator.of(context).pop();
              await closeDrawer();

              PlayxTheme.next(
                animation: PlayxThemeClipperAnimation(context: context),
              );
            },
            child: Row(
              children: [
                Icon(isDark ? Icons.light_mode : Icons.dark_mode, size: 16.r),
                SizedBox(width: 8.r),
                Expanded(
                  child: CustomText(
                    isDark ? AppTrans.lightTheme : AppTrans.darkTheme,
                  ),
                ),
              ],
            ),
          ),
          const PopupMenuDivider(),

          // // 3. Support Item
          // PopupMenuItem(
          //   onTap: () {
          //     Navigator.of(context).pop();
          //     navigateToSupport(context: context);
          //   },
          //   child: Row(
          //     children: [
          //       IconInfo.svg(
          //         Asset.icons.whatsappBusinessImage,
          //         size: 16.r,
          //         // Assuming you want specific coloring or keep original SVG colors
          //       ).buildIconWidget(),
          //       SizedBox(width: 8.r),
          //       const Expanded(child: CustomText(AppTrans.support)),
          //     ],
          //   ),
          // ),

          // 4. Logout Item
          PopupMenuItem(
            onTap: () {
              // Navigator.of(context).pop();
              logout();
            },
            child: Row(
              children: [
                Icon(
                  // Using standard Icon for Android, or keep CupertinoIcons if preferred
                  Icons.logout,
                  size: 16.r,
                  color: context.colors.error,
                ),
                SizedBox(width: 8.r),
                CustomText(AppTrans.logout, color: context.colors.error),
              ],
            ),
          ),
        ],
      );
    }
  }

  void registerInstance() {
    getIt.registerSingleton(this);
  }
}
