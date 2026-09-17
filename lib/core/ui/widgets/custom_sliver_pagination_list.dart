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
    this.separated = false,
    this.applySeparator = false,
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
  final bool applySeparator;
  final bool sortGroups;
  final bool separated;

  int _getCrossAxisCount(BuildContext context) {
    final responsiveCrossAxisCounts = this.responsiveCrossAxisCounts ?? {600: 1, 900: 2, 1200: 3};

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

    final basePad = context.paddingSymmetric(horizontal: 16);
    final effectivePadding =
        padding ?? basePad.copyWith(bottom: MediaQuery.of(context).padding.bottom + 72);

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
          (ctx) => Padding(
            padding: ctx.paddingAll(16),
            child: const Center(child: CircularProgressIndicator.adaptive()),
          ),
    );

    final isGrouped = groupBy != null;

    return SliverPadding(
      padding: effectivePadding,
      sliver: isGrouped
          ? _ResponsiveGroupedListSliver<P, T>(
              pagingController: pagingController,
              groupBy: groupBy!,
              sortGroups: sortGroups,
              groupSeparatorBuilder: groupSeparatorBuilder,
              delegate: delegate,
            )
          : _ResponsiveNormalListOrGridSliver<P, T>(
              pagingController: pagingController,
              delegate: delegate,
              crossAxisCount: crossAxisCount,
              gridMainAxisSpacing: gridMainAxisSpacing,
              gridCrossAxisSpacing: gridCrossAxisSpacing,
              separated: separated,
            ),
    );
  }
}

class _ResponsiveGroupedListSliver<P, T> extends StatelessWidget {
  final PagingController<P, T> pagingController;
  final String Function(T item) groupBy;
  final bool sortGroups;
  final Widget Function(String group)? groupSeparatorBuilder;
  final PagedChildBuilderDelegate<T> delegate;

  const _ResponsiveGroupedListSliver({
    required this.pagingController,
    required this.groupBy,
    required this.sortGroups,
    this.groupSeparatorBuilder,
    required this.delegate,
  });

  @override
  Widget build(BuildContext context) {
    return PagedSliverGroupedListView<P, T, String>(
      pagingController: pagingController,
      groupBy: groupBy,
      sort: sortGroups,
      groupSeparatorBuilder: (group) => groupSeparatorBuilder?.call(group) ?? 32.hBox,
      builderDelegate: delegate,
    );
  }
}

class _ResponsiveNormalListOrGridSliver<P, T> extends StatelessWidget {
  final PagingController<P, T> pagingController;
  final PagedChildBuilderDelegate<T> delegate;
  final int crossAxisCount;
  final double gridMainAxisSpacing;
  final double gridCrossAxisSpacing;
  final bool separated;

  const _ResponsiveNormalListOrGridSliver({
    required this.pagingController,
    required this.delegate,
    required this.crossAxisCount,
    required this.gridMainAxisSpacing,
    required this.gridCrossAxisSpacing,
    required this.separated,
  });

  @override
  Widget build(BuildContext context) {
    if (crossAxisCount <= 1) {
      return PagedSliverList.separated(
        pagingController: pagingController,
        builderDelegate: delegate,
        separatorBuilder: (_, _) {
          if (!separated) return const SizedBox.shrink();
          return gridMainAxisSpacing.hBox;
        },
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
