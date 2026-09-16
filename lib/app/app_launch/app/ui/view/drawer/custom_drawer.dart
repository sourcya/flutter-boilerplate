part of '../../imports/app_imports.dart';

class CustomDrawer extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final Widget child;
  final bool disabledGestures;
  AppController get controller => AppController.instance;

  const CustomDrawer({
    super.key,
    required this.navigationShell,
    required this.child,
    this.disabledGestures = true,
  });

  @override
  Widget build(BuildContext context) {
    final isWideWeb = context.isWideLayout;
    final railCollapsedWidth = ResponsiveConfig.railWidth.r;
    final railExpandedWidth = ResponsiveConfig.drawerExpandedRailWidth.r;

    return AdvancedCustomDrawer(
      breakpoint: ResponsiveConfig.landscapeBreakpoint,
      railMinWidth: railCollapsedWidth,
      railMaxWidth: railExpandedWidth,
      openRatio: context.isAppLandscape
          ? context.height > 720
                ? .25
                : .4
          : 269 / 375,
      openScale: context.width >= 700 ? 1.0 : 0.85,
      backdrop: Container(
        width: context.width,
        height: context.height,
        color: context.colors.background,
      ),
      controller: controller.drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: 300.milliseconds,
      rtlOpening: PlayxLocalization.isCurrentLocaleArabic(),
      disabledGestures: disabledGestures,
      drawer: ValueListenableBuilder(
        valueListenable: AppController.instance.drawerController,
        builder: (context, value, child) {
          return CustomDrawerBody(
            isWideWeb: isWideWeb,
            isExpanded: value.visible,
            navigationShell: navigationShell,
          );
        },
      ),
      child: child,
    );
  }
}
