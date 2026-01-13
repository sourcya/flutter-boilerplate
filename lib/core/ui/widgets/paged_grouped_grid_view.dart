part of '../ui.dart';

class PagedGroupedGridView<PageKeyType, ItemType, SortType>
    extends BoxScrollView {
  const PagedGroupedGridView({
    super.key,
    required this.pagingController,
    required this.builderDelegate,
    this.shrinkWrapFirstPageIndicators = false,
    required this.groupBy,
    this.groupComparator,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.itemComparator,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.separator = const SizedBox.shrink(),
    super.scrollDirection,
    super.reverse,
    super.controller,
    super.primary,
    super.physics,
    super.shrinkWrap,
    super.padding,
    super.cacheExtent,
    super.semanticChildCount,
    super.dragStartBehavior,
    super.keyboardDismissBehavior,
    super.restorationId,
    super.clipBehavior,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  });

  /// Matches [PagedLayoutBuilder.pagingController].
  final PagingController<PageKeyType, ItemType> pagingController;

  /// Matches [PagedLayoutBuilder.builderDelegate].
  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  /// Matches [PagedLayoutBuilder.shrinkWrapFirstPageIndicators].
  final bool shrinkWrapFirstPageIndicators;

  /// Matches [SliverGroupedListView.groupBy].
  final SortType Function(ItemType element) groupBy;

  /// Matches [SliverGroupedListView.groupComparator].
  final int Function(SortType value1, SortType value2)? groupComparator;

  /// Matches [SliverGroupedListView.itemComparator].
  final int Function(ItemType element1, ItemType element2)? itemComparator;

  /// Matches [SliverGroupedListView.groupSeparatorBuilder].
  final Widget Function(SortType value)? groupSeparatorBuilder;

  /// Matches [SliverGroupedListView.groupHeaderBuilder].
  final Widget Function(ItemType element)? groupHeaderBuilder;

  /// Matches [SliverGroupedListView.order].
  final GroupedListOrder order;

  /// Matches [SliverGroupedListView.sort].
  final bool sort;

  /// Matches [SliverGroupedListView.separator].
  final Widget separator;

  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  Widget buildChildLayout(BuildContext context) {
    return PagedSliverGroupedGrid(
      pagingController: pagingController,
      builderDelegate: builderDelegate,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      groupBy: groupBy,
      groupComparator: groupComparator,
      groupHeaderBuilder: groupHeaderBuilder,
      itemComparator: itemComparator,
      crossAxisCount: crossAxisCount,
      mainAxisSpacing: mainAxisSpacing,
      crossAxisSpacing: crossAxisSpacing,
      childAspectRatio: childAspectRatio,
    );
  }
}

class PagedSliverGroupedGrid<PageKeyType, ItemType, SortType>
    extends StatelessWidget {
  const PagedSliverGroupedGrid({
    required this.pagingController,
    required this.builderDelegate,
    this.shrinkWrapFirstPageIndicators = false,
    required this.groupBy,
    this.groupComparator,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.itemComparator,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.separator = const SizedBox.shrink(),
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
    this.childAspectRatio = 1.0,
  });

  /// Matches [PagedLayoutBuilder.pagingController].
  final PagingController<PageKeyType, ItemType> pagingController;

  /// Matches [PagedLayoutBuilder.builderDelegate].
  final PagedChildBuilderDelegate<ItemType> builderDelegate;

  /// Matches [PagedLayoutBuilder.shrinkWrapFirstPageIndicators].
  final bool shrinkWrapFirstPageIndicators;

  /// Matches [SliverGroupedListView.groupBy].
  final SortType Function(ItemType element) groupBy;

  /// Matches [SliverGroupedListView.groupComparator].
  final int Function(SortType value1, SortType value2)? groupComparator;

  /// Matches [SliverGroupedListView.itemComparator].
  final int Function(ItemType element1, ItemType element2)? itemComparator;

  /// Matches [SliverGroupedListView.groupSeparatorBuilder].
  final Widget Function(SortType value)? groupSeparatorBuilder;

  /// Matches [SliverGroupedListView.groupHeaderBuilder].
  final Widget Function(ItemType element)? groupHeaderBuilder;

  /// Matches [SliverGroupedListView.order].
  final GroupedListOrder order;

  /// Matches [SliverGroupedListView.sort].
  final bool sort;

  /// Matches [SliverGroupedListView.separator].
  final Widget separator;

  final int crossAxisCount;
  final double mainAxisSpacing;
  final double crossAxisSpacing;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    Widget buildLayout(
      IndexedWidgetBuilder itemBuilder,
      int itemCount, {
      WidgetBuilder? statusIndicatorBuilder,
    }) =>
        MultiSliver(
          children: [
            SliverGroupedGridView<ItemType, SortType>(
              elements: pagingController.itemList ?? [],
              groupBy: groupBy,
              groupComparator: groupComparator,
              groupSeparatorBuilder: groupSeparatorBuilder,
              groupHeaderBuilder: groupHeaderBuilder,
              indexedItemBuilder: (context, item, index) =>
                  builderDelegate.itemBuilder(context, item, index),
              itemComparator: itemComparator,
              order: order,
              sort: sort,
            ),
            if (statusIndicatorBuilder != null)
              SliverToBoxAdapter(
                child: statusIndicatorBuilder(context),
              ),
          ],
        );

    return PagedLayoutBuilder<PageKeyType, ItemType>(
      layoutProtocol: PagedLayoutProtocol.sliver,
      pagingController: pagingController,
      builderDelegate: builderDelegate,
      shrinkWrapFirstPageIndicators: shrinkWrapFirstPageIndicators,
      completedListingBuilder: (
        context,
        itemBuilder,
        itemCount,
        noMoreItemsIndicatorBuilder,
      ) =>
          buildLayout(
        itemBuilder,
        itemCount,
        statusIndicatorBuilder: noMoreItemsIndicatorBuilder,
      ),
      loadingListingBuilder: (
        context,
        itemBuilder,
        itemCount,
        progressIndicatorBuilder,
      ) =>
          buildLayout(
        itemBuilder,
        itemCount,
        statusIndicatorBuilder: progressIndicatorBuilder,
      ),
      errorListingBuilder: (
        context,
        itemBuilder,
        itemCount,
        errorIndicatorBuilder,
      ) =>
          buildLayout(
        itemBuilder,
        itemCount,
        statusIndicatorBuilder: errorIndicatorBuilder,
      ),
    );
  }
}
