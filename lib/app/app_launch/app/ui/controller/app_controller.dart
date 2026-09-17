part of '../imports/app_imports.dart';

class AppController extends GetxController with AppAuthMixin, AppDrawerMixin {
  static AppController get instance => Get.find<AppController>();

  final loadingStatus = Rx(const LoadingStatus.idle());
  final RxBool showVersionCode = RxBool(false);
  final activeAppModules = <AppModule>[].obs;

  late final List<CustomNavigationDestinationItem> drawerNavItems = [
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.icDashboard),
      label: AppTrans.dashboard,
      navigationIndex: 0,
      route: Routes.dashboard,
    ),
  ];

  late final List<CustomNavigationDestinationItem> otherDrawerItems = [
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.icSupport),
      label: AppTrans.support,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.icSettings),
      label: AppTrans.settings,
      navigationIndex: 1,
      route: Routes.settings,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.icLogout),
      label: AppTrans.logout,
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    initDrawerState();
    unawaited(setupSettings());
    unawaited(updateCurrentUser());
  }

  Future<void> setupSettings() async {
    try {
      showVersionCode.value = await EnvManger.instance.showVersionCode;
      await updateAppModules();
    } on Object catch (e, st) {
      debugPrint('Error in setupSettings: $e\n$st');
      showVersionCode.value = false;
    }
  }

  Future<void> updateAppModules({List<AppModule>? modules}) async {
    try {
      final appModules = modules ?? await MyPreferenceManger.instance.getActiveAppModules();
      activeAppModules.assignAll(appModules);
      await MyPreferenceManger.instance.saveActiveAppModules(appModules);

      final enabledTypes = appModules.map((module) => module.type).toSet();
      final drawerItems = allModuleDrawerItems.where((item) {
        final module = item.module;
        if (module == null) return true;
        return enabledTypes.contains(module.type);
      }).toList();

      moduleDrawerItems.assignAll(drawerItems);
      moduleDrawerItems.refresh();

      // The router may not have resolved an initial route yet this early in
      // boot (e.g. right after app start), in which case GoRouter throws
      // instead of returning null.
      String? currentRoute;
      try {
        currentRoute = PlayxNavigation.currentRouteName;
      } on Object {
        currentRoute = null;
      }
      final moduleRoutes = allModuleDrawerItems
          .map((item) => item.route)
          .whereType<String>()
          .toSet();
      final enabledRoutes = drawerItems.map((item) => item.route).whereType<String>().toSet();
      if (currentRoute != null &&
          moduleRoutes.contains(currentRoute) &&
          !enabledRoutes.contains(currentRoute)) {
        AppNavigation.navigateToHome();
      }
    } on Object catch (e, st) {
      debugPrint('Error in updateAppModules: $e\n$st');
    }
  }

  @override
  void onClose() {
    disposeDrawerState();
    super.onClose();
  }

  Future<void> handleLogout({
    bool showLoadingOverlay = true,
    bool navigateToLogin = true,
    BuildContext? context,
    bool showConfirmation = true,
  }) async {
    if (showConfirmation) {
      final ctx = context ?? NavigationUtils.navigationContext;
      if (ctx != null) {
        final isConfirmed = await showLogoutConfirmDialog(context: ctx);
        if (!isConfirmed) return;
      }
    }
    unawaited(closeDrawer());
    if (showLoadingOverlay) {
      loadingStatus.value = const LoadingStatus.logout();
    }
    await ApiHelper.instance.logout();
    currentUser.value = null;
    currentSubscription.value = null;
    await Future.delayed(const Duration(milliseconds: 200));
    loadingStatus.value = const LoadingStatus.idle();
    if (navigateToLogin) {
      AppNavigation.navigateToLogin();
    }
  }
}
