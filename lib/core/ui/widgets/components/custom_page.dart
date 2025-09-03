part of '../../ui.dart';

class CustomPageScaffold extends StatelessWidget {
  final StatefulNavigationShell? navigationShell;
  final Widget? child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final bool canShowDrawer;
  final bool canShowNavigationRail;

  /// Decides whether to show bottom navigation bar or not
  final bool showBottomNav;

  final bool disabledGestures;
  final GoRouterState state;

  const CustomPageScaffold({
    this.child,
    this.title,
    this.padding,
    this.appBar,
    this.canShowDrawer = false,
    this.disabledGestures = true,
    this.canShowNavigationRail = false,
    this.showBottomNav = false,
    required this.state,
  }) : navigationShell = null;

  const CustomPageScaffold.navigationShell({
    required this.navigationShell,
    this.title,
    this.padding,
    this.appBar,
    this.canShowDrawer = false,
    this.disabledGestures = true,
    this.canShowNavigationRail = false,
    this.showBottomNav = false,
    required this.state,
  }) : child = null;

  @override
  Widget build(BuildContext context) {
    final scaffoldChild = buildScaffoldChild(context);

    final canPop = !(NavigationUtils.mainRoutes
            .contains(PlayxNavigation.currentRouteName) &&
        PlayxNavigation.currentRouteName != AppPages.homeRoute);

    // Manage back button press for home routes
    // As it should navigate to home when pressed back button pressed on home routes
    // Then it can exit the app
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        PlayxNavigation.offAllNamed(AppPages.homeRoute);
      },
      child: Obx(() {
        final appController = AppController.instance;
        return Stack(
          children: [
            PlatformScaffold(
              body: scaffoldChild,
              key: navigationShell != null
                  ? ValueKey(navigationShell!.currentIndex)
                  : null,
              backgroundColor: context.colors.surface,
              bottomNavBar: appController.showBottomNav.value &&
                      showBottomNav &&
                      navigationShell != null
                  ? buildCustomNavigationBar(
                      navigationShell: navigationShell!,
                      context: context,
                    )
                  : null,
            ),
            Obx(() {
              return LoadingOverlay(
                loadingStatus: appController.loadingStatus.value,
              );
            }),
          ],
        );
      }),
    );
  }

  Widget buildScaffoldChild(BuildContext context) {
    final drawer = canShowDrawer && navigationShell != null
        ? CustomNavigationDrawer(
            navigationShell: navigationShell!,
          )
        : null;
    final navigationRail = canShowNavigationRail && navigationShell != null
        ? CustomNavigationRail(
            navigationShell: navigationShell!,
          )
        : null;

    if (navigationRail != null) {
      return Row(
        children: [
          navigationRail,
          Expanded(
            child: Scaffold(
              body: navigationShell ?? child,
              drawer: drawer,
            ),
          ),
        ],
      );
    } else if (drawer != null) {
      return Scaffold(
        body: navigationShell ?? child,
        drawer: drawer,
      );
    } else {
      return navigationShell ?? child ?? const SizedBox.shrink();
    }
  }

  static Page<dynamic> buildNavigationShellPage({
    required GoRouterState state,
    required StatefulNavigationShell navigationShell,
    bool canShowDrawer = true,
    bool showBottomNav = true,
    bool canShowNavigationRail = true,
    bool disabledGestures = true,
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold.navigationShell(
            navigationShell: navigationShell,
            canShowDrawer: canShowDrawer,
            disabledGestures: disabledGestures,
            canShowNavigationRail: canShowNavigationRail,
            showBottomNav: showBottomNav,
            state: state,
          );
        },
      ),
      key: state.pageKey,
      name: state.name,
    );
  }

  static Page<dynamic> buildPage({
    required GoRouterState state,
    required Widget child,
    bool showBottomNav = true,
    bool canShowDrawer = true,
    bool canShowNavigationRail = true,
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold(
            showBottomNav: showBottomNav,
            canShowDrawer: canShowDrawer,
            state: state,
            child: child,
          );
        },
      ),
      key: state.pageKey,
      name: state.name,
    );
  }
}
