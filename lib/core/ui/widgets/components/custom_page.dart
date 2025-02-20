part of '../../ui.dart';

class CustomPageScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final bool canShowDrawer;
  final bool canShowNavigationRail;

  /// Decides whether to show bottom navigation bar or not
  final bool showBottomNav;

  const CustomPageScaffold({
    required this.navigationShell,
    this.title,
    this.padding,
    this.appBar,
    this.showBottomNav = true,
    this.canShowDrawer = true,
    this.canShowNavigationRail = false,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldChild = buildScaffoldChild(context);

    final canPop = !(NavigationUtils.mainRoutes
            .contains(PlayxNavigation.currentRouteName) &&
        PlayxNavigation.currentRouteName != Routes.dashboard);

    // Manage back button press for home routes
    // As it should navigate to home when pressed back button pressed on home routes
    // Then it can exit the app
    return PopScope(
      canPop: canPop,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) {
          return;
        }
        PlayxNavigation.offAllNamed(Routes.dashboard);
      },
      child: Obx(() {
        final appController= AppController.instance;
        return PlatformScaffold(
          body: Stack(
            children: [
              scaffoldChild,
              Obx(() {
                return LoadingOverlay(
                  isLoading: appController.isLoggingOut.value,
                  loadingText: AppTrans.loggingOutText,
                );
              }),
            ],
          ),
          key: ValueKey(navigationShell.currentIndex),
          backgroundColor: context.colors.surface,
          bottomNavBar: appController.showBottomNav.value && showBottomNav
              ? buildCustomNavigationBar(
                  navigationShell: navigationShell,
                  context: context,
                )
              : null,
        );
      }),
    );
  }

  Widget buildScaffoldChild(BuildContext context) {
    final drawer = canShowDrawer
        ? CustomNavigationDrawer(
            navigationShell: navigationShell,
          )
        : null;
    final navigationRail = canShowNavigationRail
        ? CustomNavigationRail(
            navigationShell: navigationShell,
          )
        : null;

    if (navigationRail != null) {
      return Row(
        children: [
          navigationRail,
          Expanded(
            child: Scaffold(
              body: navigationShell,
              drawer: drawer,
            ),
          ),
        ],
      );
    } else if (drawer != null) {
      return Scaffold(
        body: navigationShell,
        drawer: drawer,
      );
    } else {
      return navigationShell;
    }
  }

  static Page<dynamic> buildPage({
    required GoRouterState state,
    required StatefulNavigationShell navigationShell,
    bool showBottomNav = true,
    bool canShowDrawer = true,
    bool canShowNavigationRail = true,
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold(
            navigationShell: navigationShell,
            showBottomNav: showBottomNav,
            canShowDrawer: canShowDrawer,
            canShowNavigationRail: canShowNavigationRail,
          );
        },
      ),
      key: state.pageKey,
      name: state.name,
    );
  }
}
