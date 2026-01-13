part of '../../ui.dart';

class CustomPageScaffold extends StatelessWidget {
  final StatefulNavigationShell? navigationShell;
  final Widget? child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final bool canShowDrawer;
  final bool disabledGestures;

  /// Decides whether to show bottom navigation bar or not
  final bool showBottomNav;

  final GoRouterState state;

  const CustomPageScaffold({
    this.child,
    this.title,
    this.padding,
    this.appBar,
    this.canShowDrawer = false,
    this.disabledGestures = true,
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
    this.showBottomNav = false,
    required this.state,
  }) : child = null;

  @override
  Widget build(BuildContext context) {
    final appController = AppController.instance;

    final scaffoldChild = PlatformScaffold(
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          navigationShell ?? child ?? const SizedBox.shrink(),
          Obx(() {
            return LoadingOverlay(
              loadingStatus: appController.loadingStatus.value,
            );
          }),
        ],
      ),
    );

    return navigationShell != null && canShowDrawer
        ? Obx(() {
            return CustomDrawer(
              navigationShell: navigationShell!,
              disabledGestures:
                  AppController.instance.disableDrawerGestures.value ||
                      disabledGestures,
              child: scaffoldChild,
            );
          })
        : scaffoldChild;
  }

  static Page<dynamic> buildNavigationShellPage({
    required GoRouterState state,
    required StatefulNavigationShell navigationShell,
    bool canShowDrawer = true,
    bool disabledGestures = true,
    bool showBottomNav = true,
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold.navigationShell(
            navigationShell: navigationShell,
            canShowDrawer: canShowDrawer,
            showBottomNav: showBottomNav,
            disabledGestures: disabledGestures,
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
  }) {
    return CupertinoPage(
      child: Builder(
        builder: (context) {
          return CustomPageScaffold(
            canShowDrawer: canShowDrawer,
            showBottomNav: showBottomNav,
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
