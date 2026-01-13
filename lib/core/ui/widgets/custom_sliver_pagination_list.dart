part of '../ui.dart';

class ResponsivePagedSliverView<P, T> extends StatelessWidget {
  const ResponsivePagedSliverView({
    super.key,
    required this.pagingController,
    required this.itemBuilder,
    this.responsiveCrossAxisCounts,
    this.padding,
    this.gridMainAxisSpacing = 8.0,
    this.gridCrossAxisSpacing = 8.0,
    this.firstPageErrorIndicatorBuilder,
    this.firstPageProgressIndicatorBuilder,
    this.newPageProgressIndicatorBuilder,
    this.noItemsFoundIndicatorBuilder,
    this.emptyDataMessage,
    this.heightFactor = 0.5,

    /// NEW → enables grouped list mode
    this.groupBy,
    this.groupSeparatorBuilder,
    this.sortGroups = false,
  });

  final PagingController<P, T> pagingController;

  final Widget Function(BuildContext context, T item, int index) itemBuilder;

  final Map<double, int>? responsiveCrossAxisCounts;

  final double heightFactor;
  final EdgeInsetsGeometry? padding;

  final double gridMainAxisSpacing;
  final double gridCrossAxisSpacing;

  final WidgetBuilder? firstPageErrorIndicatorBuilder;
  final WidgetBuilder? firstPageProgressIndicatorBuilder;
  final WidgetBuilder? newPageProgressIndicatorBuilder;
  final WidgetBuilder? noItemsFoundIndicatorBuilder;

  final String? emptyDataMessage;

  /// ✨ NEW: Grouped List Properties
  final String Function(T item)? groupBy;
  final Widget Function(String group)? groupSeparatorBuilder;
  final bool sortGroups;

  int _getCrossAxisCount(BuildContext context) {
    final responsiveCrossAxisCounts =
        this.responsiveCrossAxisCounts ??
        {
          1400: 3,
          840: 2,
          0: 1,
        };

    final width = MediaQuery.of(context).size.width;
    final sortedBreakpoints = responsiveCrossAxisCounts.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    for (final bp in sortedBreakpoints) {
      if (width >= bp) return responsiveCrossAxisCounts[bp]!;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final crossAxisCount = _getCrossAxisCount(context);

    final effectivePadding =
        padding ??
        EdgeInsets.only(
          right: 8,
          left: 8,
          top: 8,
          bottom: MediaQuery.of(context).padding.bottom + 72,
        );

    final delegate = PagedChildBuilderDelegate<T>(
      itemBuilder: itemBuilder,
      animateTransitions: true,
      firstPageErrorIndicatorBuilder:
          firstPageErrorIndicatorBuilder ??
          (_) => SizedBox(
            height: context.height * .4,
            child: EmptyDataWidget(
              error: emptyDataMessage,
              onRetryClicked: pagingController.refresh,
              animationHeight: context.height * heightFactor,
            ),
          ),
      noItemsFoundIndicatorBuilder:
          noItemsFoundIndicatorBuilder ??
          (_) => SizedBox(
            height: context.height * .4,
            child: EmptyDataWidget(
              error: emptyDataMessage,
              onRetryClicked: pagingController.refresh,
              animationHeight: context.height * heightFactor,
            ),
          ),
      firstPageProgressIndicatorBuilder:
          firstPageProgressIndicatorBuilder ??
          (_) => SizedBox(
            height: context.height * .4,
            child: const CustomLoading(),
          ),
      newPageProgressIndicatorBuilder:
          newPageProgressIndicatorBuilder ??
          (_) => const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator.adaptive()),
          ),
    );

    final isGrouped = groupBy != null;

    return SliverPadding(
      padding: effectivePadding,
      sliver: isGrouped
          ? _buildGroupedList(delegate)
          : _buildNormalListOrGrid(delegate, crossAxisCount),
    );
  }

  /// -------------------------------
  ///   GROUPED LIST BUILDER
  /// -------------------------------
  Widget _buildGroupedList(PagedChildBuilderDelegate<T> delegate) {
    return PagedSliverGroupedListView<P, T, String>(
      pagingController: pagingController,
      groupBy: groupBy!,
      sort: sortGroups,
      groupSeparatorBuilder: (group) =>
          groupSeparatorBuilder?.call(group) ?? const SizedBox(height: 32),
      builderDelegate: delegate,
    );
  }

  /// -------------------------------
  ///   NORMAL LIST OR GRID
  /// -------------------------------
  Widget _buildNormalListOrGrid(
    PagedChildBuilderDelegate<T> delegate,
    int crossAxisCount,
  ) {
    if (crossAxisCount <= 1) {
      return PagedSliverList<P, T>(
        pagingController: pagingController,
        builderDelegate: delegate,
      );
    }

    return PagedSliverAlignedGrid.count(
      pagingController: pagingController,
      builderDelegate: delegate,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: gridMainAxisSpacing,
      crossAxisSpacing: gridCrossAxisSpacing,
    );
  }
}
