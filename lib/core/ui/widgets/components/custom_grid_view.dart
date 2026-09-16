part of '../../ui.dart';

/// Responsive card grid. Column count follows the active breakpoint.
class CustomGridView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final double spacing;
  final int? mobileColumns;
  final int? tabletColumns;
  final int? desktopColumns;
  final ScrollPhysics? physics;
  final bool shrinkWrap;

  const CustomGridView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    this.spacing = 12,
    this.mobileColumns,
    this.tabletColumns,
    this.desktopColumns,
    this.physics,
    this.shrinkWrap = false,
  });

  int _columnsFor(BuildContext context) {
    return context.deviceInfo.type.valueWhen(
      mobile: mobileColumns ?? 1,
      tablet: tabletColumns ?? 2,
      desktop: desktopColumns ?? 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (itemCount == 0) {
      return const EmptyDataWidget();
    }
    final columns = _columnsFor(context);
    return GridView.builder(
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: spacing.r,
        mainAxisSpacing: spacing.r,
        childAspectRatio: context.isAppLandscape ? 1.6 : 1.35,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
