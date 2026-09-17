part of '../../ui.dart';

/// A flexible base page used to display searchable and refreshable content,
/// supporting:
/// - Table view
/// - List/Grid view
/// - A fully custom content builder that overrides the table/list toggle
///
/// If [contentBuilder] is provided:
///   • Table/List toggle will be hidden
///   • [tableBuilder] and [listBuilder] will be ignored
///
/// Otherwise:
///   • Toggle visibility can be controlled using [showTableToggle]
///   • Switches between [tableBuilder] and [listBuilder]
class ContentLandscapeViewPage<T> extends StatelessWidget {
  /// Page title shown in the AppBar.
  final String title;

  /// Search controller (optional when using controller constructor).
  final TextEditingController searchController;

  /// Refresh callback triggered by [RefreshIndicator].
  final Future<void> Function()? onRefresh;

  /// Called whenever the search query changes.
  final Function(String)? onSearchChanged;

  /// Whether the search bar should be visible.
  final bool showSearch;

  /// Whether the table/list toggle should be visible.
  /// If [contentBuilder] is provided, this is ignored.
  final bool showTableToggle;

  /// Optional filter button displayed in the header.
  final Widget? filterButton;

  /// Optional action button displayed at the end of the header.
  final Widget? endActionButton;

  /// Custom content builder that completely replaces
  /// the table/list builders and hides the toggle.
  final Widget Function(BuildContext context)? contentBuilder;

  /// Builder for table view content.
  /// Ignored when [contentBuilder] is provided.
  final Widget Function(BuildContext context) tableBuilder;

  /// Builder for list or grid view.
  /// Ignored when [contentBuilder] is provided.
  final Widget Function(BuildContext context) listBuilder;

  /// Message displayed when the response is empty.
  final String emptyMessage;

  /// Defines grid responsiveness (width → crossAxisCount).
  final Map<double, int>? responsiveCrossAxisCounts;

  /// Controls whether the table view is active.
  final RxBool isTableView;

  final Widget? topWidget;

  final bool addPopScope;
  final bool isInitialized;

  ContentLandscapeViewPage({
    super.key,
    required this.title,
    required this.tableBuilder,
    required this.listBuilder,
    this.contentBuilder,
    required this.searchController,
    this.onRefresh,
    this.onSearchChanged,
    this.filterButton,
    this.endActionButton,
    this.showSearch = true,
    this.showTableToggle = true,
    this.emptyMessage = AppTrans.emptyResponse,
    this.responsiveCrossAxisCounts,
    this.topWidget,
    RxBool? isTableView,
    this.addPopScope = false,
    this.isInitialized = true,
  }) : isTableView = isTableView ?? false.obs;

  ContentLandscapeViewPage.withController({
    super.key,
    required this.title,
    required BasePagedController<T> controller,
    required this.tableBuilder,
    required this.listBuilder,
    this.contentBuilder,
    this.filterButton,
    this.endActionButton,
    this.showSearch = true,
    this.showTableToggle = true,
    Future<void> Function()? onRefresh,
    Function(String)? onSearchChanged,
    String? emptyMessage,
    this.responsiveCrossAxisCounts,
    this.topWidget,
    RxBool? isTableView,
    this.isInitialized = true,
    this.addPopScope = false,
  }) : searchController = controller.searchController,
       onRefresh = onRefresh ?? controller.refreshData,
       onSearchChanged = onSearchChanged ?? controller.updateSearch,
       emptyMessage = emptyMessage ?? AppTrans.emptyResponse,
       isTableView = isTableView ?? controller.isTableView;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isInitialized: isInitialized,
      title: title,
      addPopScope: addPopScope,
      childBuilder: (_) => RefreshIndicator.adaptive(
        onRefresh: onRefresh ?? () async {},
        child: CustomScrollView(
          slivers: [
            if (topWidget != null)
              SliverToBoxAdapter(
                child: topWidget,
              ),
            SliverToBoxAdapter(child: 12.hBox),
            SliverToBoxAdapter(
              child: _ContentLandscapeHeader(
                title: title,
                showSearch: showSearch,
                searchController: searchController,
                onSearchChanged: onSearchChanged,
                filterButton: filterButton,
                endActionButton: endActionButton,
                showTableToggle: showTableToggle,
                contentBuilder: contentBuilder,
                isTableView: isTableView,
              ),
            ),
            Obx(
              () => SliverAnimatedSwitcher(
                duration: 300.ms,
                child: contentBuilder != null
                    ? SliverToBoxAdapter(
                        child: contentBuilder!(context),
                      )
                    : isTableView.value
                    ? _ContentLandscapeTableSliver(
                        heightFraction: 0.8,
                        table: tableBuilder(context),
                      )
                    : listBuilder(context),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 8.r + context.mediaQuery.padding.bottom,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContentLandscapeHeader extends StatelessWidget {
  final String title;
  final bool showSearch;
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;
  final Widget? filterButton;
  final Widget? endActionButton;
  final bool showTableToggle;
  final Widget Function(BuildContext context)? contentBuilder;
  final RxBool isTableView;

  const _ContentLandscapeHeader({
    required this.title,
    required this.showSearch,
    required this.searchController,
    this.onSearchChanged,
    this.filterButton,
    this.endActionButton,
    required this.showTableToggle,
    this.contentBuilder,
    required this.isTableView,
  });

  @override
  Widget build(BuildContext context) {
    final showToggle = showTableToggle && contentBuilder == null;

    return Padding(
      padding: context.paddingSymmetric(horizontal: 8),
      child: Row(
        children: [
          8.wBox,
          CustomText(
            title,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
          const Spacer(),
          if (showSearch)
            CustomSearch(
              onChanged: onSearchChanged,
              controller: searchController,
              maxWidth: 300.r,
            ),
          if (filterButton != null) filterButton!,
          if (showToggle)
            Obx(
              () => ViewToggle(
                isTableView: isTableView.value,
                onToggle: (value) => isTableView.value = value,
              ),
            ),
          if (endActionButton != null) endActionButton!,
        ],
      ),
    );
  }
}

class _ContentLandscapeTableSliver extends StatelessWidget {
  final double heightFraction;
  final Widget table;

  const _ContentLandscapeTableSliver({
    required this.heightFraction,
    required this.table,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.height * heightFraction,
        child: table,
      ),
    );
  }
}
