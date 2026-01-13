part of '../../ui.dart';

class GenericPagedView<T> extends StatelessWidget {
  final String title;

  // Core
  final PagingController<int, T> pagingController;
  final TextEditingController searchController;

  // Functions
  final Future<void> Function()? onRefresh;
  final Function(String)? onSearchChanged;

  final bool showSearch;
  final Widget? filterButton;
  final Widget? endActionButton;

  final Widget Function(BuildContext, PagingController<int, T>) tableBuilder;
  final Widget Function(BuildContext, T, int) itemBuilder;

  final String? emptyMessage;
  final Map<double, int>? responsiveCrossAxisCounts;

  final RxBool isTableView;
  final Widget? topWidget;
  final bool isShowToggleButton;

  final bool useScaffold;
  final bool addPopScope;
  final Widget? counterWidget;
  final double titleFontSize;
  final FontWeight titleFontWeight;

  GenericPagedView({
    super.key,
    required this.title,
    required this.pagingController,
    required this.searchController,
    this.onRefresh,
    required this.tableBuilder,
    required this.itemBuilder,
    this.showSearch = true,
    this.onSearchChanged,
    this.filterButton,
    this.endActionButton,
    this.emptyMessage,
    this.responsiveCrossAxisCounts,
    bool initialTableView = false,
    this.topWidget,
    this.isShowToggleButton = true,
    this.useScaffold = true,
    this.addPopScope = false,
    this.counterWidget,
    this.titleFontWeight = FontWeight.w500,
    this.titleFontSize = 20,
    RxBool? isTableView,
  }) : isTableView = isTableView ?? initialTableView.obs;

  GenericPagedView.withController({
    super.key,
    required this.title,
    required BasePagedController<T> controller,
    required this.tableBuilder,
    required this.itemBuilder,
    this.showSearch = true,
    this.endActionButton,
    Future<void> Function()? onRefresh,
    Function(String)? onSearchChanged,
    this.filterButton,
    String? emptyMessage,
    this.responsiveCrossAxisCounts,
    this.topWidget,
    bool? initialTableView,
    this.isShowToggleButton = true,
    this.useScaffold = true,
    this.addPopScope = false,
    this.counterWidget,
    this.titleFontWeight = FontWeight.w500,
    this.titleFontSize = 20,
  }) : pagingController = controller.pagingController,
       searchController = controller.searchController,
       onRefresh = onRefresh ?? controller.refreshData,
       onSearchChanged = onSearchChanged ?? controller.updateSearch,
       emptyMessage = emptyMessage ?? AppTrans.emptyResponse,
       isTableView = (initialTableView != null
           ? initialTableView.obs
           : controller.isTableView);

  @override
  Widget build(BuildContext context) {
    Widget content = CustomScrollView(
      physics: useScaffold
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: SizedBox(height: 12.h)),
        if (topWidget != null) SliverToBoxAdapter(child: topWidget),
        _buildHeader(context),
        Obx(() {
          return SliverAnimatedSwitcher(
            duration: 300.ms,
            child: isTableView.value
                ? _buildTable(context)
                : _buildGrid(context),
          );
        }),
        SliverToBoxAdapter(
          child: SizedBox(height: 8.h + context.mediaQuery.padding.bottom),
        ),
      ],
    );

    if (addPopScope) {
      content = WillPopScope(
        onWillPop: () async => true,
        child: content,
      );
    }

    if (useScaffold) {
      return CustomScaffold(
        title: title,
        showWhatsAppSupport: true,
        addPopScope: addPopScope,
        child: RefreshIndicator(
          onRefresh: onRefresh ?? () async {},
          child: content,
        ),
      );
    } else {
      return content;
    }
  }

  // -------------------- HEADER --------------------
  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.h),
        child: Row(
          children: [
            8.boxR,
            CustomText(
              title,
              fontSize: titleFontSize.sp,
              fontWeight: titleFontWeight,
            ),
            if (counterWidget != null) ...[
              7.5.boxW,
              counterWidget ?? const SizedBox.shrink(),
            ],
            const Spacer(),
            if (showSearch) _buildSearchBar(context),
            8.boxR,
            filterButton ?? const SizedBox.shrink(),
            if (isShowToggleButton)
              Obx(() {
                return ViewToggle(
                  isTableView: isTableView.value,
                  onToggle: (value) => isTableView.value = value,
                );
              }),
            endActionButton ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.h),
      child: CustomTextField(
        controller: searchController,
        onChanged: onSearchChanged,
        prefix: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconInfo.svg(
              Assets.icons.search,
              color: context.colors.subtitleTextColor,
              size: 18.h,
            ).buildIconWidget(),
          ],
        ),
        suffix: ValueListenableBuilder(
          valueListenable: searchController,
          builder:
              (BuildContext context, TextEditingValue value, Widget? child) {
                return AnimatedVisibility(
                  duration: 250.ms,
                  isVisible: value.text.isNotEmpty,
                  child: IconButton(
                    onPressed: () {
                      searchController.clear();
                      onSearchChanged?.call('');
                    },
                    icon: const Icon(Icons.close),
                  ),
                );
              },
        ),
        fillColor: context.colors.cardColor,
        hint: AppTrans.search.tr(context: context),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 8.h,
          vertical: 8.h,
        ),
      ),
    );
  }

  // -------------------- TABLE / GRID --------------------
  Widget _buildTable(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.height * .8,
        child: tableBuilder(context, pagingController),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    return ResponsivePagedSliverView(
      pagingController: pagingController,
      padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 4.h),
      itemBuilder: itemBuilder,
      emptyDataMessage: emptyMessage,
      responsiveCrossAxisCounts: responsiveCrossAxisCounts,
    );
  }
}
