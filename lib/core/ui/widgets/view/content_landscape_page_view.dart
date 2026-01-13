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
  final TextEditingController? searchController;

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
  ContentLandscapeViewPage({
    super.key,
    required this.title,
    required this.tableBuilder,
    required this.listBuilder,
    this.contentBuilder,
    this.searchController,
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
  }) : isTableView = isTableView ?? false.obs;

  // ---------------------------------------------------------------------------
  // Controller-Based Constructor
  // ---------------------------------------------------------------------------

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
    this.addPopScope = false,
  }) : searchController = controller.searchController,
       onRefresh = onRefresh ?? controller.refreshData,
       onSearchChanged = onSearchChanged ?? controller.updateSearch,
       emptyMessage = emptyMessage ?? AppTrans.emptyResponse,
       isTableView = isTableView ?? controller.isTableView;

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: title,
      addPopScope: addPopScope,
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: CustomScrollView(
          slivers: [
            if (topWidget != null)
              SliverToBoxAdapter(
                child: topWidget,
              ),
            SliverToBoxAdapter(child: SizedBox(height: 12.r)),
            _buildHeader(context),
            Obx(
              () => SliverAnimatedSwitcher(
                duration: 300.ms,
                child: contentBuilder != null
                    ? SliverToBoxAdapter(
                        child: contentBuilder!(context),
                      )
                    : isTableView.value
                    ? _buildTable(context)
                    : _buildList(context),
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

  // ---------------------------------------------------------------------------
  // Header
  // ---------------------------------------------------------------------------

  Widget _buildHeader(BuildContext context) {
    final showToggle = showTableToggle && contentBuilder == null;

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r),
        child: Row(
          children: [
            8.boxR,
            CustomText(
              title,
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
            ),
            // Toggle here and maybe we can add new custom widget here
            const Spacer(),
            if (showSearch) _buildSearchBar(context),
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
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.r),
      child: CustomTextField(
        controller: searchController,
        onChanged: onSearchChanged,
        prefix: IconInfo.svg(
          Assets.icons.search,
          color: context.colors.subtitleTextColor,
          size: 18.r,
        ).buildIconWidget(),
        fillColor: context.colors.cardColor,
        hint: AppTrans.search.tr(context: context),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8.r,
          vertical: 8.r,
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Table & List Builders
  // ---------------------------------------------------------------------------

  Widget _buildTable(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.height * 0.8,
        child: tableBuilder(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return listBuilder(context);
  }
}
