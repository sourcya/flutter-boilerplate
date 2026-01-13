part of '../../../imports/app_imports.dart';

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
    // Define dimensions for the Rail
    final double railCollapsedWidth =
        48.r + (context.isLtr ? context.mediaQueryPadding.left : context.mediaQueryPadding.right);
    final double railExpandedWidth = context.isMobile ? context.width * .3 : context.width * .25;

    return AdvancedCustomDrawer(
      // Trigger rail mode when screen is wide enough (Tablet/Web/Landscape)
      breakpoint: 700.0,
      railMinWidth: railCollapsedWidth,
      railMaxWidth: railExpandedWidth,
      openRatio: context.isLandscape
          ? context.height > 720
                ? .25
                : .4
          : .65,
      // On Rail mode, we want the scale to be 1.0 (flat),
      // on mobile we might want the shrinking effect.
      openScale: context.width >= 700 ? 1.0 : 0.85,

      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: context.isDarkMode
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF688CBB),
                    context.colors.surface,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    context.colors.surface,
                    context.colors.primary.withValues(alpha: .1),
                  ],
                ),
        ),
      ),
      controller: controller.drawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: 300.milliseconds,
      rtlOpening: PlayxLocalization.isCurrentLocaleArabic(),
      disabledGestures: disabledGestures,
      childDecoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      drawer: ValueListenableBuilder(
        valueListenable: AppController.instance.drawerController,
        builder: (context, value, child) {
          return CustomDrawerBody(
            navigationShell: navigationShell,
            isExpanded: value.visible,
          );
        },
      ),
      child: child,
    );
  }
}
