part of '../../ui.dart';

/// Tab descriptor for [AppScrollableTabBar].
class AppScrollableTabBarItem {
  const AppScrollableTabBarItem({
    this.label,
    this.child,
  }) : assert(label != null || child != null, 'Provide label or child');

  final String? label;
  final Widget? child;
}

/// Shared tab bar (route/zone details, settings, etc.).
///
/// Matches TMT `PlacesDetailsTabBar`: bottom divider, `primary50` fill (light),
/// primary bottom indicator, 8px top radius. Pair with [TabBarView] via the same
/// [TabController].
class AppScrollableTabBar extends StatelessWidget {
  const AppScrollableTabBar({
    super.key,
    required this.controller,
    this.tabs,
    this.items,
    this.isScrollable = false,
    this.tabAlignment,
    this.indicatorSize,
    this.indicatorPadding = EdgeInsets.zero,
    this.overlayColor,
    this.tabPadding,
    this.padding,
    this.backgroundColor,
    this.semanticsLabel,
    this.indicatorFillColor,
    this.borderColor,
    this.selectedLabelColor,
    this.unselectedLabelColor,
    this.labelStyle,
    this.unselectedLabelStyle,
    this.indicatorBorderWidth,
    this.indicatorTopRadius,
    this.tabChildWrapper,
    this.tabSurfaceWrapper,
  }) : assert(
         tabs != null || items != null,
         'Provide tabs or items',
       );

  final TabController controller;

  /// Pre-built [Tab] widgets. When set, [items] and [tabChildWrapper] are ignored.
  final List<Widget>? tabs;

  final List<AppScrollableTabBarItem>? items;
  final bool isScrollable;
  final TabAlignment? tabAlignment;
  final TabBarIndicatorSize? indicatorSize;
  final EdgeInsetsGeometry indicatorPadding;
  final WidgetStateProperty<Color?>? overlayColor;
  final EdgeInsetsGeometry? tabPadding;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final String? semanticsLabel;
  final Color? indicatorFillColor;
  final Color? borderColor;
  final Color? selectedLabelColor;
  final Color? unselectedLabelColor;
  final TextStyle? labelStyle;
  final TextStyle? unselectedLabelStyle;
  final double? indicatorBorderWidth;
  final double? indicatorTopRadius;

  final Widget Function(
    BuildContext context,
    int index,
    Widget child,
  )?
  tabChildWrapper;
  final Widget Function(BuildContext context, int index, Widget child)? tabSurfaceWrapper;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDarkMode;
    final resolvedBorder = borderColor ?? (isDark ? colors.cardBorderColor : colors.borderColor);
    final resolvedIndicatorFill =
        indicatorFillColor ??
        (isDark ? colors.settingsSegmentSelectedFill : AppColors.primaryPalette.primary50);
    final resolvedSelectedLabel =
        selectedLabelColor ?? (isDark ? colors.onSurface : colors.foreground);
    final resolvedUnselectedLabel = unselectedLabelColor ?? colors.mutedForeground;
    final baseLabelStyle = context.labelMediumTS.copyWith(
      fontWeight: FontWeight.w600,
    );
    final resolvedLabelStyle = (labelStyle ?? baseLabelStyle).copyWith(
      color: labelStyle?.color ?? resolvedSelectedLabel,
    );
    final resolvedUnselectedLabelStyle = (unselectedLabelStyle ?? baseLabelStyle).copyWith(
      color: unselectedLabelStyle?.color ?? resolvedUnselectedLabel,
    );
    final radius = indicatorTopRadius ?? 8.r;
    final borderWidth = indicatorBorderWidth ?? 2.r;
    final resolvedTabPadding = tabPadding ?? context.paddingSymmetric(horizontal: 12);
    final resolvedIndicatorSize =
        indicatorSize ?? (isScrollable ? TabBarIndicatorSize.label : TabBarIndicatorSize.tab);

    final tabBar = TabBar(
      controller: controller,
      isScrollable: isScrollable,
      tabAlignment: isScrollable ? (tabAlignment ?? TabAlignment.start) : null,
      indicatorSize: resolvedIndicatorSize,
      indicatorPadding: indicatorPadding,
      overlayColor: overlayColor,
      indicator: BoxDecoration(
        color: resolvedIndicatorFill,
        border: Border(
          bottom: BorderSide(color: colors.primary, width: borderWidth),
        ),
        borderRadius: BorderRadius.only(
          topLeft: radius.radiusCircular,
          topRight: radius.radiusCircular,
        ),
      ),
      dividerColor: AppColors.transparent,
      labelColor: resolvedSelectedLabel,
      unselectedLabelColor: resolvedUnselectedLabel,
      labelStyle: resolvedLabelStyle,
      unselectedLabelStyle: resolvedUnselectedLabelStyle,
      labelPadding: EdgeInsetsDirectional.zero,
      tabs:
          tabs ??
          [
            for (var i = 0; i < items!.length; i++)
              _AppScrollableTabBarTab(
                controller: controller,
                index: i,
                item: items![i],
                tabPadding: resolvedTabPadding,
                labelStyle: resolvedLabelStyle,
                unselectedLabelStyle: resolvedUnselectedLabelStyle,
                tabChildWrapper: tabChildWrapper,
                tabSurfaceWrapper: tabSurfaceWrapper,
              ),
          ],
    );

    final bar = Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: resolvedBorder,
            width: 1.r,
          ),
        ),
      ),
      child: semanticsLabel == null ? tabBar : Semantics(label: semanticsLabel, child: tabBar),
    );

    if (padding == null && backgroundColor == null) return bar;

    return ColoredBox(
      color: backgroundColor ?? AppColors.transparent,
      child: Padding(
        padding: padding ?? context.paddingZero(),
        child: bar,
      ),
    );
  }
}

class _AppScrollableTabBarTab extends StatelessWidget {
  const _AppScrollableTabBarTab({
    required this.controller,
    required this.index,
    required this.item,
    required this.tabPadding,
    required this.labelStyle,
    required this.unselectedLabelStyle,
    this.tabChildWrapper,
    this.tabSurfaceWrapper,
  });

  final TabController controller;
  final int index;
  final AppScrollableTabBarItem item;
  final EdgeInsetsGeometry tabPadding;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Widget Function(BuildContext context, int index, Widget child)? tabChildWrapper;
  final Widget Function(BuildContext context, int index, Widget child)? tabSurfaceWrapper;

  @override
  Widget build(BuildContext context) {
    final child = Padding(
      padding: tabPadding,
      child: _AppScrollableTabBarTabChild(
        controller: controller,
        index: index,
        item: item,
        labelStyle: labelStyle,
        unselectedLabelStyle: unselectedLabelStyle,
        tabChildWrapper: tabChildWrapper,
      ),
    );

    return Tab(
      child: tabSurfaceWrapper?.call(context, index, child) ?? child,
    );
  }
}

class _AppScrollableTabBarTabChild extends StatelessWidget {
  const _AppScrollableTabBarTabChild({
    required this.controller,
    required this.index,
    required this.item,
    required this.labelStyle,
    required this.unselectedLabelStyle,
    this.tabChildWrapper,
  });

  final TabController controller;
  final int index;
  final AppScrollableTabBarItem item;
  final TextStyle labelStyle;
  final TextStyle unselectedLabelStyle;
  final Widget Function(BuildContext context, int index, Widget child)? tabChildWrapper;

  @override
  Widget build(BuildContext context) {
    if (item.child != null) {
      final child = item.child!;
      return tabChildWrapper?.call(context, index, child) ?? child;
    }

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final selected = controller.index == index;
        final style = selected ? labelStyle : unselectedLabelStyle;

        final child = CustomText(
          item.label ?? '',
          textStyle: style,
          fontSize: style.fontSize,
          fontWeight: style.fontWeight,
          height: style.height,
          letterSpacing: style.letterSpacing,
          color: style.color,
          textAlign: TextAlign.center,
          maxLines: 1,
          isResponsive: false,
        );

        return tabChildWrapper?.call(context, index, child) ?? child;
      },
    );
  }
}
