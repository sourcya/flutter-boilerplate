import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';
import 'package:playx_navigation/playx_navigation.dart';

import '../../navigation/app_routes.dart';
import '../../navigation/navigation_utils.dart';
import '../../resources/colors/app_colors.dart';
import '../../resources/translation/app_translations.dart';
import '../loading_overlay.dart';
import 'bottom_nav/bottom_navigation/ui/imports/bottom_navigation_imports.dart';
import 'navigation_drawer/ui/imports/custom_navigation_drawer_imports.dart';

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
        final bottomNavController =
            Get.find<CustomBottomNavigationController>();
        final drawerController = Get.find<CustomNavigationDrawerController>();
        return PlatformScaffold(
          body: Stack(
            children: [
              scaffoldChild,
              Obx(() {
                return LoadingOverlay(
                  isLoading: drawerController.isLoggingOut.value,
                  loadingText: AppTrans.loggingOutText,
                );
              }),
            ],
          ),
          key: ValueKey(navigationShell.currentIndex),
          backgroundColor: context.colors.surface,
          bottomNavBar: bottomNavController.showBottomNav.value && showBottomNav
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
