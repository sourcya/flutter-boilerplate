// Standard iOS 10 tab bar height.
part of '../../../imports/app_imports.dart';

class CustomPlatformNavBar extends PlatformNavBar {
  const CustomPlatformNavBar({
    super.key,
    super.widgetKey,
    super.backgroundColor,
    super.items,
    super.itemChanged,
    super.currentIndex,
    super.height,
    super.material,
    super.material3,
    super.cupertino,
  });

  @override
  Widget createMaterialWidget(BuildContext context) {
    final useMaterial3 = Theme.of(context).useMaterial3;
    return useMaterial3
        ? _createMaterial3Widget(context)
        : _createMaterial2Widget(context);
  }

  Widget _createMaterial3Widget(BuildContext context) {
    final data = material3?.call(context, platform(context));
    final selectedIndex = data?.selectedIndex ?? currentIndex ?? 0;
    final destinations =
        data?.items ??
        items?.map(
          (item) {
            return CustomNavigationDestination(
              // key: ,
              icon: item.icon,
              label: item.label ?? '',
              selectedIcon: item.activeIcon,
              tooltip: item.tooltip,
            );
          },
        ).toList() ??
        [];
    assert(destinations.length >= 2);
    assert(0 <= selectedIndex && selectedIndex < destinations.length);

    return CustomNavigationBar(
      key: data?.widgetKey ?? widgetKey,
      destinations: destinations,
      animationDuration: data?.animationDuration,
      backgroundColor: data?.backgroundColor ?? backgroundColor,
      elevation: data?.elevation,
      height: data?.height ?? height,
      indicatorColor: data?.indicatorColor,
      indicatorShape: data?.indicatorShape,
      labelBehavior: data?.labelBehavior,
      onDestinationSelected: data?.onDestinationSelected ?? itemChanged,
      selectedIndex: selectedIndex,
      shadowColor: data?.shadowColor,
      surfaceTintColor: data?.surfaceTintColor,
      overlayColor: data?.overlayColor,
    );
  }

  Widget _createMaterial2Widget(BuildContext context) {
    final data = material?.call(context, platform(context));

    final bar = BottomNavigationBar(
      items: data?.items ?? items ?? const <BottomNavigationBarItem>[],
      currentIndex: data?.currentIndex ?? currentIndex ?? 0,
      onTap: data?.itemChanged ?? itemChanged,
      iconSize: data?.iconSize ?? 24.0,
      fixedColor: data?.activeColor,
      type: data?.type,
      key: data?.bottomNavigationBarKey,
      backgroundColor: data?.backgroundColor ?? backgroundColor,
      elevation: data?.elevation ?? 8.0,
      selectedFontSize: data?.selectedFontSize ?? 14.0,
      selectedItemColor: data?.selectedItemColor,
      showSelectedLabels: data?.showSelectedLabels ?? true,
      showUnselectedLabels: data?.showUnselectedLabels,
      unselectedFontSize: data?.unselectedFontSize ?? 12.0,
      unselectedItemColor: data?.unselectedItemColor,
      selectedIconTheme: data?.selectedIconTheme ?? const IconThemeData(),
      selectedLabelStyle: data?.selectedLabelStyle,
      unselectedIconTheme: data?.unselectedIconTheme ?? const IconThemeData(),
      unselectedLabelStyle: data?.unselectedLabelStyle,
      mouseCursor: data?.mouseCursor,
      enableFeedback: data?.enableFeedback,
      landscapeLayout: data?.landscapeLayout,
      useLegacyColorScheme: data?.useLegacyColorScheme ?? true,
    );

    return BottomAppBar(
      color: data?.backgroundColor ?? backgroundColor,
      elevation: data?.elevation,
      key: data?.widgetKey ?? widgetKey,
      shape: data?.shape,
      clipBehavior: data?.clipBehavior ?? Clip.none,
      notchMargin: data?.notchMargin ?? 4.0,
      height: data?.height ?? height,
      padding: data?.padding,
      surfaceTintColor: data?.surfaceTintColor,
      shadowColor: data?.shadowColor,
      child: bar,
    );
  }
}
