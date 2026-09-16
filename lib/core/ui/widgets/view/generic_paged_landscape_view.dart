part of '../../ui.dart';

class GenericPagedView<T> extends StatelessWidget {
  final String title;
  final String? subtitle;

  // Core
  final PagingController<int, T> pagingController;
  final TextEditingController searchController;

  // Shared paginator controller for table footer ([_PaginationControlsRow]) +
  // [CustomPagingTableView] so both stay in sync.
  final PaginatorController? paginatorController;

  // Functions
  final Future<void> Function()? onRefresh;
  final Function(String)? onSearchChanged;
  final double maxSearchWidth;

  final bool showSearch;
  final Widget? filterButton;

  /// When set, renders [SearchFilterBar] with filter inside search (see [filterIsActive]).
  final RxBool? showFilterButton;
  final RxBool? filterIsActive;
  final VoidCallback? onFilterTap;
  final Widget? endActionButton;

  // tableBuilder now receives the PaginatorController so the caller can
  // pass it straight into CustomPagingTableView without keeping external state.
  final Widget Function(
    BuildContext,
    PagingController<int, T>,
    PaginatorController,
  )
  tableBuilder;
  final Widget Function(BuildContext, T, int) itemBuilder;

  final String? emptyMessage;
  final Map<double, int>? responsiveCrossAxisCounts;

  final RxBool isTableView;
  final Widget? topWidget;
  final bool isShowToggleButton;
  final bool showHeaderTitle;

  final bool useScaffold;
  final bool addPopScope;

  /// When true, renders a fixed-height table + footer for use inside a parent
  /// [ListView] (uses [SliverToBoxAdapter] instead of [SliverFillRemaining]).
  final bool isEmbedded;

  /// When true with [isEmbedded], the table expands to fill remaining parent height.
  final bool embeddedFillRemainingHeight;

  /// Gap between the embedded table card and pagination footer (Figma: 12).
  final double embeddedPaginationTopSpacing;
  final double embeddedEmptyTableHeight;
  final double embeddedMaxTableHeight;
  final bool uppercaseHeaderTitle;
  final Widget? counterWidget;
  final RxnInt? totalItemsCount;
  final RxnInt? totalPagesCount;
  final Future<void> Function(int value)? onRowsPerPageChanged;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final EdgeInsetsGeometry? gridPadding;
  final double? headerEndPadding;
  final double? verticalSpaceBetweenHeaderAndContent;
  final bool isInitialized;
  final List<String>? tabLabels;
  final RxInt? selectedTabIndex;
  final ValueChanged<int>? onTabChanged;

  /// Shows [PagedSegmentedTabBar] in the header (Figma `PageHeader` left cluster).
  final bool showTabs;

  // Internal: created once and reused across builds (stable reference).
  final PaginatorController _effectivePaginatorController;

  static Widget _empty(BuildContext context, dynamic item, int index) => const SizedBox.shrink();

  GenericPagedView({
    super.key,
    required this.title,
    this.subtitle,
    required this.pagingController,
    required this.searchController,
    this.paginatorController,
    this.onRefresh,
    required this.tableBuilder,
    required this.itemBuilder,
    this.showSearch = true,
    this.onSearchChanged,
    this.filterButton,
    this.showFilterButton,
    this.filterIsActive,
    this.onFilterTap,
    this.maxSearchWidth = 300,
    this.endActionButton,
    this.emptyMessage,
    this.gridPadding,
    this.responsiveCrossAxisCounts,
    bool initialTableView = false,
    this.topWidget,
    this.isShowToggleButton = true,
    this.showHeaderTitle = true,
    this.useScaffold = true,
    this.addPopScope = false,
    this.isEmbedded = false,
    this.embeddedFillRemainingHeight = false,
    this.embeddedPaginationTopSpacing = 0,
    this.embeddedEmptyTableHeight = 280,
    this.embeddedMaxTableHeight = 400,
    this.uppercaseHeaderTitle = false,
    this.counterWidget,
    this.totalItemsCount,
    this.totalPagesCount,
    this.onRowsPerPageChanged,
    this.titleFontWeight = FontWeight.w600,
    this.titleFontSize = 24,
    this.isInitialized = true,
    RxBool? isTableView,
    this.headerEndPadding,
    this.verticalSpaceBetweenHeaderAndContent,
    this.tabLabels,
    this.selectedTabIndex,
    this.onTabChanged,
    this.showTabs = false,
  }) : isTableView = isTableView ?? initialTableView.obs,
       _effectivePaginatorController = paginatorController ?? PaginatorController();

  GenericPagedView.withController({
    super.key,
    required this.title,
    this.subtitle,
    required BasePagedController<T> controller,
    required this.tableBuilder,
    required this.itemBuilder,
    this.paginatorController,
    this.showSearch = true,
    this.endActionButton,
    Future<void> Function()? onRefresh,
    Function(String)? onSearchChanged,
    Future<void> Function(int value)? onRowsPerPageChanged,
    this.filterButton,
    this.showFilterButton,
    this.filterIsActive,
    this.onFilterTap,
    String? emptyMessage,
    this.responsiveCrossAxisCounts,
    this.topWidget,
    bool? initialTableView,
    this.isShowToggleButton = true,
    this.showHeaderTitle = true,
    this.useScaffold = true,
    this.addPopScope = false,
    this.isEmbedded = false,
    this.embeddedFillRemainingHeight = false,
    this.embeddedPaginationTopSpacing = 0,
    this.embeddedEmptyTableHeight = 280,
    this.embeddedMaxTableHeight = 400,
    this.uppercaseHeaderTitle = false,
    this.maxSearchWidth = 300,
    this.counterWidget,
    this.titleFontWeight = FontWeight.w600,
    this.titleFontSize = 24,
    this.gridPadding,
    this.headerEndPadding,
    this.verticalSpaceBetweenHeaderAndContent = 10,
    this.isInitialized = true,
    this.tabLabels,
    this.selectedTabIndex,
    this.onTabChanged,
    this.showTabs = false,
  }) : pagingController = controller.pagingController,
       searchController = controller.searchController,
       totalItemsCount = controller.totalItemsCount,
       totalPagesCount = controller.totalPagesCount,
       onRowsPerPageChanged = onRowsPerPageChanged ?? controller.updatePageSize,
       onRefresh = onRefresh ?? controller.refreshData,
       onSearchChanged = onSearchChanged ?? controller.updateSearch,
       emptyMessage = emptyMessage ?? AppTrans.emptyResponse,
       isTableView = controller.isTableView,
       _effectivePaginatorController = paginatorController ?? PaginatorController() {
    final resolvedInitialTableView = initialTableView;
    if (resolvedInitialTableView != null &&
        controller.isTableView.value != resolvedInitialTableView) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (controller.isTableView.value != resolvedInitialTableView) {
          controller.isTableView.value = resolvedInitialTableView;
        }
      });
    }
  }

  GenericPagedView.withControllerTableOnly({
    super.key,
    required this.title,
    this.subtitle,
    required BasePagedController<T> controller,
    required this.tableBuilder,
    this.paginatorController,
    this.showSearch = true,
    this.endActionButton,
    Future<void> Function()? onRefresh,
    Function(String)? onSearchChanged,
    Future<void> Function(int value)? onRowsPerPageChanged,
    this.filterButton,
    this.showFilterButton,
    this.filterIsActive,
    this.onFilterTap,
    String? emptyMessage,
    this.topWidget,
    this.useScaffold = true,
    this.addPopScope = false,
    this.isEmbedded = false,
    this.embeddedFillRemainingHeight = false,
    this.embeddedPaginationTopSpacing = 0,
    this.embeddedEmptyTableHeight = 280,
    this.embeddedMaxTableHeight = 400,
    this.uppercaseHeaderTitle = false,
    this.maxSearchWidth = 300,
    this.counterWidget,
    this.titleFontWeight = FontWeight.w500,
    this.titleFontSize = 20,
    this.gridPadding,
    this.headerEndPadding,
    this.verticalSpaceBetweenHeaderAndContent,
    this.isInitialized = true,
    this.tabLabels,
    this.selectedTabIndex,
    this.onTabChanged,
    this.showTabs = false,
  }) : pagingController = controller.pagingController,
       searchController = controller.searchController,
       totalItemsCount = controller.totalItemsCount,
       totalPagesCount = controller.totalPagesCount,
       onRowsPerPageChanged = onRowsPerPageChanged ?? controller.updatePageSize,
       onRefresh = onRefresh ?? controller.refreshData,
       onSearchChanged = onSearchChanged ?? controller.updateSearch,
       emptyMessage = emptyMessage ?? AppTrans.emptyResponse,
       isTableView = true.obs,
       itemBuilder = _empty,
       responsiveCrossAxisCounts = null,
       isShowToggleButton = false,
       showHeaderTitle = true,
       _effectivePaginatorController = paginatorController ?? PaginatorController();

  @override
  Widget build(BuildContext context) {
    final headerEnd = headerEndPadding ?? (endActionButton == null ? 16.r : 0);

    if (isEmbedded) {
      final tableSection = Obx(() {
        if (!isTableView.value) {
          return const SizedBox.shrink();
        }
        return _GenericPagedEmbeddedTable<T>(
          tableBuilder: tableBuilder,
          pagingController: pagingController,
          paginatorController: _effectivePaginatorController,
          totalItemsCount: totalItemsCount,
          totalPagesCount: totalPagesCount,
          onRowsPerPageChanged: onRowsPerPageChanged,
          isFillRemainingHeight: embeddedFillRemainingHeight,
          paginationTopSpacing: embeddedPaginationTopSpacing,
          emptyTableHeight: embeddedEmptyTableHeight,
          maxTableHeight: embeddedMaxTableHeight,
        );
      });

      Widget embedded = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (topWidget != null) topWidget!,
          _GenericPagedHeaderBar(
            title: title,
            titleFontSize: titleFontSize,
            titleFontWeight: titleFontWeight,
            uppercaseTitle: uppercaseHeaderTitle,
            counterWidget: counterWidget,
            showTabs: showTabs,
            tabLabels: tabLabels,
            selectedTabIndex: selectedTabIndex,
            onTabChanged: onTabChanged,
            showSearch: showSearch,
            searchController: searchController,
            onSearchChanged: onSearchChanged,
            maxSearchWidth: maxSearchWidth,
            filterButton: filterButton,
            showFilterButton: showFilterButton,
            filterIsActive: filterIsActive,
            onFilterTap: onFilterTap,
            isShowToggleButton: isShowToggleButton,
            showHeaderTitle: showHeaderTitle,
            isTableView: isTableView,
            endActionButton: endActionButton,
            headerEndPadding: headerEnd,
          ),
          if (verticalSpaceBetweenHeaderAndContent != null)
            SizedBox(height: verticalSpaceBetweenHeaderAndContent),
          if (embeddedFillRemainingHeight) Expanded(child: tableSection) else tableSection,
        ],
      );

      if (addPopScope && !useScaffold) {
        embedded = PopScope(
          canPop: false,
          onPopInvokedWithResult: (didPop, result) {
            if (didPop || kIsWeb) return;
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
            AppNavigation.navigateToHome();
          },
          child: embedded,
        );
      }

      if (useScaffold) {
        return CustomScaffold(
          isInitialized: isInitialized,
          title: title,
          showWhatsAppSupport: true,
          addPopScope: addPopScope,
          child: RefreshIndicator.adaptive(
            onRefresh: onRefresh ?? () async {},
            child: embedded,
          ),
        );
      }
      return embedded;
    }

    Widget content = CustomScrollView(
      physics: useScaffold
          ? const AlwaysScrollableScrollPhysics()
          : const NeverScrollableScrollPhysics(),
      slivers: [
        // SliverToBoxAdapter(child: 16.hBox),
        if (topWidget != null) SliverToBoxAdapter(child: topWidget),
        _GenericPagedHeader(
          title: title,
          titleFontSize: titleFontSize,
          titleFontWeight: titleFontWeight,
          uppercaseTitle: uppercaseHeaderTitle,
          counterWidget: counterWidget,
          showTabs: showTabs,
          tabLabels: tabLabels,
          selectedTabIndex: selectedTabIndex,
          onTabChanged: onTabChanged,
          showSearch: showSearch,
          searchController: searchController,
          onSearchChanged: onSearchChanged,
          maxSearchWidth: maxSearchWidth,
          filterButton: filterButton,
          showFilterButton: showFilterButton,
          filterIsActive: filterIsActive,
          onFilterTap: onFilterTap,
          isShowToggleButton: isShowToggleButton,
          showHeaderTitle: showHeaderTitle,
          isTableView: isTableView,
          endActionButton: endActionButton,
          headerEndPadding: headerEnd,
        ),
        if (verticalSpaceBetweenHeaderAndContent != null)
          SliverToBoxAdapter(
            child: SizedBox(
              height: verticalSpaceBetweenHeaderAndContent,
            ),
          ),
        Obx(() {
          return SliverAnimatedSwitcher(
            duration: 300.ms,
            child: isTableView.value
                ? _GenericPagedTableBody<T>(
                    tableBuilder: tableBuilder,
                    pagingController: pagingController,
                    paginatorController: _effectivePaginatorController,
                    totalItemsCount: totalItemsCount,
                    totalPagesCount: totalPagesCount,
                    onRowsPerPageChanged: onRowsPerPageChanged,
                  )
                : _GenericPagedGridBody<T>(
                    pagingController: pagingController,
                    gridPadding: gridPadding,
                    itemBuilder: itemBuilder,
                    emptyMessage: emptyMessage,
                    responsiveCrossAxisCounts: responsiveCrossAxisCounts,
                  ),
          );
        }),
        SliverToBoxAdapter(
          child: (8.0 + context.mediaQuery.padding.bottom).hBox,
        ),
      ],
    );

    if (addPopScope && !useScaffold) {
      content = PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop || kIsWeb) return;
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          AppNavigation.navigateToHome();
        },
        child: content,
      );
    }

    if (useScaffold) {
      return CustomScaffold(
        isInitialized: isInitialized,
        title: title,
        showWhatsAppSupport: true,
        addPopScope: addPopScope,
        child: RefreshIndicator.adaptive(
          onRefresh: onRefresh ?? () async {},
          child: content,
        ),
      );
    } else {
      return content;
    }
  }
}

class _GenericPagedSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;
  final double width;

  const _GenericPagedSearchBar({
    required this.controller,
    required this.onChanged,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = context.isDarkMode;
    final fillColor = isDark ? colors.inputBackgroundColor : AppColors.basewhite;
    final borderColor = isDark ? colors.cardBorderColor : AppColors.input;
    final hintColor = isDark ? colors.inputHintColor : AppColors.slate500;
    final textColor = isDark ? colors.inputTextColor : AppColors.slate950;

    return SizedBox(
      width: width.r,
      child: DecoratedBox(
        decoration: ShapeDecoration(
          color: fillColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: borderColor),
            borderRadius: 12.0.radius,
          ),
        ),
        child: Padding(
          padding: context.paddingSymmetric(horizontal: 12.0, vertical: 10.0),
          child: Row(
            spacing: 8.0.r,
            children: [
              IconInfo.svg(
                Asset.icons.search,
                color: hintColor,
                size: 16,
              ).buildIconWidget(),
              Expanded(
                child: TextField(
                  controller: controller,
                  onChanged: onChanged,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.43,
                    fontFamily: fontFamily(context: context),
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    isCollapsed: true,
                    border: InputBorder.none,
                    hintText: AppTrans.search.tr(context: context),
                    hintStyle: TextStyle(
                      color: hintColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.43,
                      fontFamily: fontFamily(context: context),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GenericPagedEmbeddedTable<T> extends StatelessWidget {
  final Widget Function(
    BuildContext,
    PagingController<int, T>,
    PaginatorController,
  )
  tableBuilder;
  final PagingController<int, T> pagingController;
  final PaginatorController paginatorController;
  final RxnInt? totalItemsCount;
  final RxnInt? totalPagesCount;
  final Future<void> Function(int value)? onRowsPerPageChanged;
  final bool isFillRemainingHeight;
  final double paginationTopSpacing;
  final double emptyTableHeight;
  final double maxTableHeight;

  const _GenericPagedEmbeddedTable({
    required this.tableBuilder,
    required this.pagingController,
    required this.paginatorController,
    required this.totalItemsCount,
    required this.totalPagesCount,
    this.onRowsPerPageChanged,
    this.isFillRemainingHeight = false,
    this.paginationTopSpacing = 0,
    required this.emptyTableHeight,
    required this.maxTableHeight,
  });

  @override
  Widget build(BuildContext context) {
    final body = Column(
      children: [
        Expanded(
          child: tableBuilder(
            context,
            pagingController,
            paginatorController,
          ),
        ),
        if (paginationTopSpacing > 0) SizedBox(height: paginationTopSpacing.r),
        TablePaginationControls<T>(
          pagingController: pagingController,
          paginatorController: paginatorController,
          totalItemsCount: totalItemsCount,
          totalPagesCount: totalPagesCount,
          onRowsPerPageChanged: onRowsPerPageChanged,
        ),
      ],
    );

    if (isFillRemainingHeight) {
      return body;
    }

    return Obx(() {
      final count = totalItemsCount?.value ?? pagingController.itemList?.length ?? 0;
      final height = count == 0 ? emptyTableHeight.r : maxTableHeight.r;

      return SizedBox(height: height, child: body);
    });
  }
}

class _GenericPagedHeaderTabs extends StatelessWidget {
  final bool showTabs;
  final List<String>? items;
  final RxInt? selectedTabIndex;
  final ValueChanged<int>? onTabChanged;

  const _GenericPagedHeaderTabs({
    required this.showTabs,
    this.items,
    this.selectedTabIndex,
    this.onTabChanged,
  });

  bool get _showTabBar => showTabs && items != null && items!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    if (!_showTabBar) return const SizedBox.shrink();

    return PagedSegmentedTabBar(
      items: items ?? [],
      selectedIndexRx: selectedTabIndex,
      onSelected: onTabChanged,
    );
  }
}

class _GenericPagedHeaderSearchArea extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;
  final double maxSearchWidth;
  final Widget? filterButton;
  final RxBool? showFilterButton;
  final RxBool? filterIsActive;
  final VoidCallback? onFilterTap;

  const _GenericPagedHeaderSearchArea({
    required this.searchController,
    required this.onSearchChanged,
    required this.maxSearchWidth,
    this.filterButton,
    this.showFilterButton,
    this.filterIsActive,
    this.onFilterTap,
  });

  @override
  Widget build(BuildContext context) {
    if (showFilterButton != null) {
      return Obx(
        () => SizedBox(
          width: maxSearchWidth.r,
          child: SearchFilterBar(
            searchController: searchController,
            onSearchChanged: onSearchChanged,
            showFilter: showFilterButton?.value ?? false,
            isFilterActive: filterIsActive?.value ?? false,
            onFilterTap: onFilterTap,
            padding: context.paddingZero(),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.0.r,
      children: [
        _GenericPagedSearchBar(
          controller: searchController,
          onChanged: onSearchChanged,
          width: maxSearchWidth,
        ),
        filterButton ?? const SizedBox.shrink(),
      ],
    );
  }
}

class _GenericPagedHeaderActions extends StatelessWidget {
  final Widget? counterWidget;
  final bool isShowToggleButton;
  final RxBool isTableView;
  final Widget? endActionButton;

  const _GenericPagedHeaderActions({
    this.counterWidget,
    required this.isShowToggleButton,
    required this.isTableView,
    this.endActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final actions = <Widget>[
      if (counterWidget != null)
        Obx(
          () => isTableView.value ? counterWidget! : const SizedBox.shrink(),
        ),
      if (isShowToggleButton)
        Obx(() {
          return ViewToggle(
            isTableView: isTableView.value,
            onToggle: (value) => isTableView.value = value,
          );
        }),
      if (endActionButton != null) endActionButton!,
    ];

    if (actions.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: 8.0.r,
      children: actions,
    );
  }
}

class _GenericPagedHeaderBar extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final bool uppercaseTitle;
  final Widget? counterWidget;
  final bool showTabs;
  final List<String>? tabLabels;
  final RxInt? selectedTabIndex;
  final ValueChanged<int>? onTabChanged;
  final bool showSearch;
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;
  final double maxSearchWidth;
  final Widget? filterButton;
  final RxBool? showFilterButton;
  final RxBool? filterIsActive;
  final VoidCallback? onFilterTap;
  final bool isShowToggleButton;
  final bool showHeaderTitle;
  final RxBool isTableView;
  final Widget? endActionButton;
  final double headerEndPadding;

  const _GenericPagedHeaderBar({
    required this.title,
    required this.titleFontSize,
    required this.titleFontWeight,
    this.uppercaseTitle = false,
    this.counterWidget,
    this.showTabs = false,
    this.tabLabels,
    this.selectedTabIndex,
    this.onTabChanged,
    required this.showSearch,
    required this.searchController,
    required this.onSearchChanged,
    required this.maxSearchWidth,
    this.filterButton,
    this.showFilterButton,
    this.filterIsActive,
    this.onFilterTap,
    required this.isShowToggleButton,
    required this.showHeaderTitle,
    required this.isTableView,
    this.endActionButton,
    required this.headerEndPadding,
  });

  bool get _showTabBar => showTabs && tabLabels != null && (tabLabels?.isNotEmpty == true);

  @override
  Widget build(BuildContext context) {
    final searchArea = _GenericPagedHeaderSearchArea(
      searchController: searchController,
      onSearchChanged: onSearchChanged,
      maxSearchWidth: maxSearchWidth,
      filterButton: filterButton,
      showFilterButton: showFilterButton,
      filterIsActive: filterIsActive,
      onFilterTap: onFilterTap,
    );

    final headerActions = _GenericPagedHeaderActions(
      counterWidget: counterWidget,
      isShowToggleButton: isShowToggleButton,
      isTableView: isTableView,
      endActionButton: endActionButton,
    );

    if (_showTabBar) {
      return Padding(
        padding: context.paddingOnly(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 8.0.r,
              children: [
                _GenericPagedHeaderTabs(
                  showTabs: showTabs,
                  items: tabLabels,
                  selectedTabIndex: selectedTabIndex,
                  onTabChanged: onTabChanged,
                ),
                if (showSearch)
                  SizedBox(
                    width: maxSearchWidth.r,
                    child: searchArea,
                  ),
              ],
            ),
            headerActions,
          ],
        ),
      );
    }

    return Padding(
      padding: context.paddingOnly(end: headerEndPadding),
      child: Row(
        children: [
          if (showSearch)
            searchArea
          else if (showHeaderTitle)
            Padding(
              padding: context.paddingOnly(start: 2.0),
              child: CustomText(
                uppercaseTitle ? title.tr(context: context).toUpperCase() : title,
                fontSize: titleFontSize.sp,
                fontWeight: titleFontWeight,
                height: titleFontSize <= 16 ? 1 : null,
                color: context.colors.cardForeground,
                isTranslatable: !uppercaseTitle,
              ),
            )
          else
            filterButton ?? const SizedBox.shrink(),
          const Spacer(),
          headerActions,
        ],
      ),
    );
  }
}

class _GenericPagedHeader extends StatelessWidget {
  final String title;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final bool uppercaseTitle;
  final Widget? counterWidget;
  final bool showSearch;
  final TextEditingController searchController;
  final Function(String)? onSearchChanged;
  final double maxSearchWidth;
  final Widget? filterButton;
  final RxBool? showFilterButton;
  final RxBool? filterIsActive;
  final VoidCallback? onFilterTap;
  final bool isShowToggleButton;
  final bool showHeaderTitle;
  final RxBool isTableView;
  final Widget? endActionButton;
  final double headerEndPadding;
  final bool showTabs;
  final List<String>? tabLabels;
  final RxInt? selectedTabIndex;
  final ValueChanged<int>? onTabChanged;

  const _GenericPagedHeader({
    required this.title,
    required this.titleFontSize,
    required this.titleFontWeight,
    this.uppercaseTitle = false,
    this.counterWidget,
    this.showTabs = false,
    this.tabLabels,
    this.selectedTabIndex,
    this.onTabChanged,
    required this.showSearch,
    required this.searchController,
    required this.onSearchChanged,
    required this.maxSearchWidth,
    this.filterButton,
    this.showFilterButton,
    this.filterIsActive,
    this.onFilterTap,
    required this.isShowToggleButton,
    required this.showHeaderTitle,
    required this.isTableView,
    this.endActionButton,
    required this.headerEndPadding,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: _GenericPagedHeaderBar(
        title: title,
        titleFontSize: titleFontSize,
        titleFontWeight: titleFontWeight,
        uppercaseTitle: uppercaseTitle,
        counterWidget: counterWidget,
        showTabs: showTabs,
        tabLabels: tabLabels,
        selectedTabIndex: selectedTabIndex,
        onTabChanged: onTabChanged,
        showSearch: showSearch,
        searchController: searchController,
        onSearchChanged: onSearchChanged,
        maxSearchWidth: maxSearchWidth,
        filterButton: filterButton,
        showFilterButton: showFilterButton,
        filterIsActive: filterIsActive,
        onFilterTap: onFilterTap,
        isShowToggleButton: isShowToggleButton,
        showHeaderTitle: showHeaderTitle,
        isTableView: isTableView,
        endActionButton: endActionButton,
        headerEndPadding: headerEndPadding,
      ),
    );
  }
}

class _GenericPagedTableBody<T> extends StatelessWidget {
  final Widget Function(
    BuildContext,
    PagingController<int, T>,
    PaginatorController,
  )
  tableBuilder;
  final PagingController<int, T> pagingController;
  final PaginatorController paginatorController;
  final RxnInt? totalItemsCount;
  final RxnInt? totalPagesCount;
  final Future<void> Function(int value)? onRowsPerPageChanged;

  const _GenericPagedTableBody({
    required this.tableBuilder,
    required this.pagingController,
    required this.paginatorController,
    required this.totalItemsCount,
    required this.totalPagesCount,
    this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        children: [
          Expanded(
            child: tableBuilder(
              context,
              pagingController,
              paginatorController,
            ),
          ),
          TablePaginationControls<T>(
            pagingController: pagingController,
            paginatorController: paginatorController,
            totalItemsCount: totalItemsCount,
            totalPagesCount: totalPagesCount,
            onRowsPerPageChanged: onRowsPerPageChanged,
          ),
        ],
      ),
    );
  }
}

class _GenericPagedGridBody<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final EdgeInsetsGeometry? gridPadding;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final String? emptyMessage;
  final Map<double, int>? responsiveCrossAxisCounts;

  const _GenericPagedGridBody({
    required this.pagingController,
    required this.gridPadding,
    required this.itemBuilder,
    required this.emptyMessage,
    required this.responsiveCrossAxisCounts,
  });

  @override
  Widget build(BuildContext context) {
    return ResponsivePagedSliverView(
      pagingController: pagingController,
      padding: gridPadding ?? context.paddingSymmetric(horizontal: 16.0, vertical: 16.0),
      itemBuilder: itemBuilder,
      emptyDataMessage: emptyMessage,
      separated: true,
      gridCrossAxisSpacing: 16.r,
      gridMainAxisSpacing: 16.r,
      responsiveCrossAxisCounts: responsiveCrossAxisCounts,
      applySeparator: true,
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PAGINATION CONTROLS
// Driven entirely by PaginatorController (the source of truth for the table's
// current page / rowsPerPage / total rows).  PagingController is used only to
// detect whether more pages exist beyond what is currently loaded.
// ─────────────────────────────────────────────────────────────────────────────

class TablePaginationControls<T> extends StatelessWidget {
  final PagingController<int, T> pagingController;
  final PaginatorController paginatorController;
  final RxnInt? totalItemsCount;
  final RxnInt? totalPagesCount;
  final Future<void> Function(int value)? onRowsPerPageChanged;

  const TablePaginationControls({
    required this.pagingController,
    required this.paginatorController,
    this.totalItemsCount,
    this.totalPagesCount,
    this.onRowsPerPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    final hasObservables = totalItemsCount != null || totalPagesCount != null;
    if (hasObservables) {
      return Obx(
        () => _PaginationControlsRow<T>(
          pagingController: pagingController,
          paginatorController: paginatorController,
          overrideTotalRows: totalItemsCount?.value,
          overrideTotalPages: totalPagesCount?.value,
          onRowsPerPageChanged: onRowsPerPageChanged,
        ),
      );
    }
    return _PaginationControlsRow<T>(
      pagingController: pagingController,
      paginatorController: paginatorController,
      onRowsPerPageChanged: onRowsPerPageChanged,
    );
  }
}

/// Footer row: rows-per-page + navigation for [_GenericPagedTableBody].
class _PaginationControlsRow<T> extends StatefulWidget {
  final PagingController<int, T> pagingController;
  final PaginatorController paginatorController;
  final int? overrideTotalRows;
  final int? overrideTotalPages;
  final Future<void> Function(int value)? onRowsPerPageChanged;

  /// Matches [CustomPagingTableView.pageSizeOptions] defaults.
  static const List<int> _pageSizeOptions = [10, 25, 50, 100];

  const _PaginationControlsRow({
    required this.pagingController,
    required this.paginatorController,
    this.overrideTotalRows,
    this.overrideTotalPages,
    this.onRowsPerPageChanged,
  });

  @override
  State<_PaginationControlsRow<T>> createState() => _PaginationControlsRowState<T>();
}

class _PaginationControlsRowState<T> extends State<_PaginationControlsRow<T>> {
  /// Stable merged listenable kept across rebuilds so the inner
  /// [AnimatedBuilder] doesn't detach/reattach on every parent rebuild.
  late Listenable _merged;

  /// Local rows-per-page used when the paginator is not yet attached, and as
  /// the source of truth for change handling.
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    final pc = widget.paginatorController;
    _rowsPerPage = pc.isAttached ? pc.rowsPerPage : 25;
    _merged = Listenable.merge([
      widget.paginatorController,
      widget.pagingController,
    ]);
  }

  @override
  void didUpdateWidget(_PaginationControlsRow<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.paginatorController != widget.paginatorController ||
        oldWidget.pagingController != widget.pagingController) {
      _merged = Listenable.merge([
        widget.paginatorController,
        widget.pagingController,
      ]);
    }
  }

  int _currentPage(int firstRowIndex, int pageSize) =>
      pageSize > 0 ? (firstRowIndex ~/ pageSize) + 1 : 1;

  int _totalPages(int totalRows, int pageSize) =>
      totalRows > 0 && pageSize > 0 ? (totalRows / pageSize).ceil() : 1;

  int _resolveTotalPages({
    required int totalRows,
    required int pageSize,
    int? serverPageCount,
  }) {
    if (totalRows > 0 && pageSize > 0) {
      return _totalPages(totalRows, pageSize);
    }
    return serverPageCount ?? 1;
  }

  void _goToFirstPage({bool postFrame = false}) {
    void reset() {
      if (!mounted || !widget.paginatorController.isAttached) return;
      if (widget.paginatorController.currentRowIndex == 0) return;
      widget.paginatorController.goToFirstPage();
    }

    if (postFrame) {
      WidgetsBinding.instance.addPostFrameCallback((_) => reset());
    } else {
      reset();
    }
  }

  Future<void> _handleRowsPerPageChanged(int value) async {
    if (_rowsPerPage == value) return;

    setState(() {
      _rowsPerPage = value;
    });

    // Keep [PaginatorController] in sync with the local rows-per-page value.
    final pc = widget.paginatorController;
    if (pc.isAttached && pc.rowsPerPage != value) {
      pc.setRowsPerPage(value);
    }

    await widget.onRowsPerPageChanged?.call(value);
    // Single post-frame reset after refresh/setRowsPerPage settle — avoids
    // navigating to page 1 twice (sync + post-frame) and a visible flicker.
    _goToFirstPage(postFrame: true);
  }

  static String _showingText(
    BuildContext context,
    int firstRowIndex,
    int rowsPerPage,
    int totalRows,
  ) {
    if (totalRows == 0) {
      return '${AppTrans.showing.tr(context: context)} 0–0 '
          '${AppTrans.of.tr(context: context)} 0';
    }
    final start = firstRowIndex + 1;
    final end = min(firstRowIndex + rowsPerPage, totalRows);
    return '${AppTrans.showing.tr(context: context)} $start–$end '
        '${AppTrans.of.tr(context: context)} $totalRows';
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _merged,
      builder: (context, _) {
        final paginatorController = widget.paginatorController;
        final pagingController = widget.pagingController;
        final isAttached = paginatorController.isAttached;
        final firstRowIndex =
            isAttached ? paginatorController.currentRowIndex : 0;
        final effectiveRowsPerPage =
            isAttached ? paginatorController.rowsPerPage : _rowsPerPage;
        final totalRows = widget.overrideTotalRows ??
            (isAttached
                ? paginatorController.rowCount
                : (pagingController.itemList?.length ?? 0));
        final currentPage = _currentPage(firstRowIndex, effectiveRowsPerPage);
        final totalPages = _resolveTotalPages(
          totalRows: totalRows,
          pageSize: effectiveRowsPerPage,
          serverPageCount: widget.overrideTotalPages,
        );
        // Enable previous/first when not on page 1; next when more pages or
        // rows remain; last when total pages are known and we are not on the last.
        final canGoPrevious = isAttached && currentPage > 1;
        final canGoFirst = canGoPrevious;
        final canGoNext = isAttached &&
            (currentPage < totalPages ||
                pagingController.nextPageKey != null ||
                ((firstRowIndex + effectiveRowsPerPage) < totalRows));
        final canGoLast =
            isAttached && totalPages > 1 && currentPage < totalPages;

        return Container(
          width: context.width,
          padding: context.paddingSymmetric(horizontal: 12, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  _showingText(
                    context,
                    firstRowIndex,
                    effectiveRowsPerPage,
                    totalRows,
                  ),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: context.colors.cardForeground,
                  height: 1.71,
                  isTranslatable: false,
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        AppTrans.rowsPerPage,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.cardForeground,
                        height: 1.71,
                      ),
                      8.wBox,
                      _RowsPerPageDropdown(
                        value: effectiveRowsPerPage,
                        options: _PaginationControlsRow._pageSizeOptions,
                        onChanged: (v) {
                          if (v == null) return;
                          _handleRowsPerPageChanged(v);
                        },
                      ),
                    ],
                  ),
                  32.wBox,
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _NavButton(
                        icon: Icons.first_page,
                        enabled: canGoFirst,
                        onPressed: () => paginatorController.goToFirstPage(),
                      ),
                      8.wBox,
                      _NavButton(
                        icon: Icons.chevron_left,
                        enabled: canGoPrevious,
                        onPressed: () => paginatorController.goToPreviousPage(),
                      ),
                      8.wBox,
                      CustomText(
                        '${AppTrans.page.tr(context: context)} $currentPage '
                        '${AppTrans.of.tr(context: context)} $totalPages',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: context.colors.cardForeground,
                        height: 1.71,
                        isTranslatable: false,
                      ),
                      8.wBox,
                      _NavButton(
                        icon: Icons.chevron_right,
                        enabled: canGoNext,
                        onPressed: () => paginatorController.goToNextPage(),
                      ),
                      8.wBox,
                      _NavButton(
                        icon: Icons.last_page,
                        enabled: canGoLast,
                        onPressed: () => paginatorController.goToLastPage(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Private sub-widgets ───────────────────────────────────────────────────────

class _RowsPerPageDropdown extends StatelessWidget {
  final int value;
  final List<int> options;
  final ValueChanged<int?> onChanged;

  const _RowsPerPageDropdown({
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Guard: if the current value isn't in the list (e.g. initialRowsPerPage
    // differs) fall back to the closest option so the dropdown doesn't crash.
    final safeValue = options.contains(value) ? value : options.first;

    return Container(
      constraints: BoxConstraints(maxHeight: 48.r, maxWidth: 72.r),
      padding: context.paddingSymmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: context.colors.screenCardSurface,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: context.colors.cardBorderColor.withValues(alpha: 0.7),
          width: 1.r,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: safeValue,
          items: options
              .map(
                (v) => DropdownMenuItem<int>(
                  value: v,
                  child: CustomText(
                    v.toString(),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: context.colors.cardForeground,
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          padding: context.paddingSymmetric(vertical: 4),
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 16.r,
            color: context.colors.mutedForeground,
          ),
          dropdownColor: context.colors.elevatedSurface,
          borderRadius: BorderRadius.circular(12.r),
          isDense: true,
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final bool enabled;
  final VoidCallback onPressed;

  const _NavButton({
    required this.icon,
    required this.enabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.r,
      height: 32.r,
      decoration: BoxDecoration(
        color: context.colors.screenCardSurface,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: context.colors.primary.withValues(alpha: enabled ? 1.0 : 0.4),
          width: 1.r,
        ),
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(8.r),
          child: Icon(
            icon,
            size: 16.r,
            color: context.colors.primary.withValues(alpha: enabled ? 1.0 : 0.4),
          ),
        ),
      ),
    );
  }
}
