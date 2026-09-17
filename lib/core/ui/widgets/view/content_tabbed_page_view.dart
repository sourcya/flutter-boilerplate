part of '../../ui.dart';

/// Flexible Tabbed View:
/// - Original contentBuilder / tableBuilder / listBuilder supported
/// - New optional pagingControllerBuilder per tab
/// - New optional itemBuilder / tableItemBuilder per tab
/// - Table view uses CustomPagingTableView
class ContentTabbedLandscapeViewPage<S> extends StatelessWidget {
  final String title;

  // Tabs
  final TabController? tabController;
  final Rx<S>? selectedTabRx;
  final List<S> tabs;
  final String Function(S tab) tabLabelBuilder;

  // Search / Refresh
  final TextEditingController searchController;
  final Future<void> Function()? onRefresh;
  final Function(String)? onSearchChanged;
  final bool showSearch;

  // UI Actions
  final Widget? filterButton;
  final Widget? endActionButton;
  final bool showTableToggle;
  final bool showTabToggle;
  final TogglePosition togglePosition;
  final Widget Function(BuildContext context)? customToggleBuilder;

  // Original Builders (legacy)
  final Widget Function(BuildContext, S tab)? contentBuilder;
  final Widget Function(BuildContext, S tab)? tableBuilder;
  final Widget Function(BuildContext, S tab)? listBuilder;

  // NEW paging builders (generic per tab)
  /// Provide a PagingController for the tab (can have different types per tab)
  final PagingController<int, dynamic> Function(S tab)? pagingControllerBuilder;

  /// Builds the table view for a tab given its paging controller
  final Widget Function(
    BuildContext context,
    PagingController<int, dynamic> pc,
    PaginatorController paginator,
  )?
  tablePagingBuilder;

  /// Builds the list/grid view for a tab given its paging controller
  final PaginatorController Function(S tab)? paginatorBuilder;

  /// Builds the list/grid view for a tab given an item
  final Widget Function(BuildContext context, dynamic item, int index)? itemPagingBuilder;

  final Widget? topWidget;

  final String emptyMessage;
  final String Function(S)? emptyMessageBuilder;

  final RxBool isTableView;

  final bool addPopScope;
  final bool useScaffold;

  final Widget Function(Widget child)? toggleSwitchDecorator;

  final double? verticalSpaceBetweenHeaderAndContent;
  final bool isInitialized;
  final double? searchMaxWidth;

  /// Optional suffix chip label builder for tab toggle items (e.g. count badges).
  final String? Function(S?)? suffixChipLabelBuilder;

  /// Font weight for the tab label text.
  final FontWeight? tabFontWeight;

  /// Font weight for the suffix chip label text.
  final FontWeight? tabSuffixChipFontWeight;

  /// Minimum width constraint for each tab item.
  final double? tabMinItemWidth;

  /// Border radius override for the toggle switch.
  final BorderRadius? tabBorderRadius;

  /// Padding for each individual tab item.
  final EdgeInsetsGeometry? tabItemPadding;

  /// Padding for the toggle switch container.
  final EdgeInsetsGeometry? tabPadding;

  /// Color of text/icons when unselected in the tab toggle.
  final Color? tabOnUnselectedColor;

  /// Color for the suffix chip label text in the tab toggle.
  final Color? tabSuffixChipColor;

  /// Font size for the suffix chip label text in the tab toggle.
  final double? tabSuffixChipFontSize;

  final double? tabItemFontSize;
  // Internal: created once and reused across builds (stable reference).
  final PaginatorController _effectivePaginatorController;

  ContentTabbedLandscapeViewPage({
    super.key,
    required this.title,
    this.tabController,
    this.selectedTabRx,
    required this.tabs,
    required this.tabLabelBuilder,
    this.contentBuilder,
    this.tableBuilder,
    this.listBuilder,
    required this.searchController,
    this.onRefresh,
    this.onSearchChanged,
    this.filterButton,
    this.endActionButton,
    this.showSearch = true,
    this.showTableToggle = true,
    this.showTabToggle = true,
    this.togglePosition = TogglePosition.afterTitle,
    this.customToggleBuilder,
    this.emptyMessage = AppTrans.emptyResponse,
    this.emptyMessageBuilder,
    this.pagingControllerBuilder,
    this.paginatorBuilder,
    this.tablePagingBuilder,
    this.itemPagingBuilder,
    this.topWidget,
    this.toggleSwitchDecorator,
    this.suffixChipLabelBuilder,
    this.tabFontWeight,
    this.tabSuffixChipFontWeight,
    this.tabMinItemWidth,
    this.tabBorderRadius,
    this.tabItemPadding,
    this.tabPadding,
    this.tabOnUnselectedColor,
    this.tabSuffixChipColor,
    this.tabSuffixChipFontSize,
    this.tabItemFontSize,
    RxBool? isTableView,
    this.addPopScope = false,
    this.useScaffold = true,
    this.verticalSpaceBetweenHeaderAndContent,
    this.isInitialized = true,
    this.searchMaxWidth,
  }) : isTableView = isTableView ?? false.obs,
       _effectivePaginatorController = paginatorBuilder?.call(tabs.first) ?? PaginatorController();

  @override
  Widget build(BuildContext context) {
    final toggleWidgetChild =
        customToggleBuilder?.call(context) ??
        (showTabToggle ? _ContentTabbedTabsToggleSection<S>(page: this) : null);

    final toggleWidget = toggleWidgetChild != null
        ? toggleSwitchDecorator?.call(toggleWidgetChild) ?? toggleWidgetChild
        : null;

    final List<Widget> tabsContent = tabs.map((tab) {
      return Obx(() {
        final isTable = isTableView.value;
        // 1️⃣ Use contentBuilder if provided
        if (contentBuilder != null) {
          return contentBuilder!(context, tab);
        }

        // 2️⃣ Use pagingController if provided (dynamic type)
        if (pagingControllerBuilder != null) {
          final pc = pagingControllerBuilder!(tab);
          final paginator = _effectivePaginatorController;

          if (isTable) {
            return SizedBox(
              height: context.height * .8,
              child:
                  tablePagingBuilder?.call(context, pc, paginator) ??
                  tableBuilder?.call(context, tab) ??
                  const SizedBox.shrink(),
            );
          } else {
            return itemPagingBuilder != null
                ? CustomScrollView(
                    slivers: [
                      ResponsivePagedSliverView(
                        pagingController: pc,
                        itemBuilder: itemPagingBuilder!,
                        emptyDataMessage: emptyMessageBuilder?.call(tab) ?? emptyMessage,
                      ),
                    ],
                  )
                : listBuilder?.call(context, tab) ?? const SizedBox.shrink();
          }
        }

        // 3️⃣ Fallback to original table/list builders
        if (isTable) {
          return tableBuilder?.call(context, tab) ?? const SizedBox.shrink();
        }
        return listBuilder?.call(context, tab) ?? const SizedBox.shrink();
      });
    }).toList();

    Widget body = Column(
      children: [
        12.hBox,
        if (topWidget != null) topWidget!,
        ValueListenableBuilder(
          valueListenable: AppController.instance.drawerController,
          builder: (context, value, child) {
            return _ContentTabbedHeaderBar<S>(
              page: this,
              toggleWidget: toggleWidget,
              drawerControllerValue: value,
            );
          },
        ),
        if (togglePosition == TogglePosition.belowHeader && toggleWidget != null)
          Padding(
            padding: context.paddingOnly(start: 8.0),
            child: toggleWidget,
          ),
        if (verticalSpaceBetweenHeaderAndContent != null)
          SizedBox(
            height: verticalSpaceBetweenHeaderAndContent,
          ),
        Expanded(
          child: tabController != null
              ? TabBarView(controller: tabController, children: tabsContent)
              : Obx(() {
                  final selected = selectedTabRx?.value;
                  final selectedIndex = selected != null ? tabs.indexOf(selected) : -1;
                  if (selectedIndex < 0) {
                    return const SizedBox.shrink();
                  }

                  return AnimatedSwitcher(
                    duration: 250.ms,
                    child: tabsContent[selectedIndex],
                  );
                }),
        ),
      ],
    );

    if (addPopScope && !useScaffold) {
      body = PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop || kIsWeb) return;
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          }
          AppNavigation.navigateToHome();
        },
        child: body,
      );
    }

    if (useScaffold) {
      return CustomScaffold(
        isInitialized: isInitialized,
        title: title,
        addPopScope: addPopScope,
        childBuilder: (_) => RefreshIndicator.adaptive(
          onRefresh: onRefresh ?? () async {},
          child: body,
        ),
      );
    } else {
      return body;
    }
  }
}

class _ContentTabbedHeaderBar<S> extends StatelessWidget {
  final ContentTabbedLandscapeViewPage<S> page;
  final Widget? toggleWidget;
  final AdvancedDrawerValue drawerControllerValue;

  const _ContentTabbedHeaderBar({
    required this.page,
    this.toggleWidget,
    required this.drawerControllerValue,
  });

  @override
  Widget build(BuildContext context) {
    final showTableModeToggle =
        page.showTableToggle &&
        page.contentBuilder == null &&
        ((page.tableBuilder != null || page.pagingControllerBuilder != null) &&
            (page.listBuilder != null || page.itemPagingBuilder != null));

    final isDrawerOpen = drawerControllerValue.visible;

    final double availableWidth = isDrawerOpen ? context.width * 0.75 : context.width;
    const breakpointWidth = 1100;
    final isNarrow = availableWidth < breakpointWidth;

    final leftWidgets = <Widget>[
      8.wBox,
      CustomText(
        page.title,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        textOverflow: TextOverflow.ellipsis,
      ),
      if (page.togglePosition == TogglePosition.afterTitle && toggleWidget != null)
        Flexible(
          child: Padding(
            padding: context.paddingOnly(start: 8.0),
            child: toggleWidget,
          ),
        ),
      8.wBox,
    ];

    final rightWidgets = <Widget>[
      if (page.showSearch)
        CustomSearch(
          onChanged: page.onSearchChanged,
          controller: page.searchController,
          maxWidth: page.searchMaxWidth ?? 308.0.r,
        ),
      if (page.togglePosition == TogglePosition.afterSearch && toggleWidget != null)
        Flexible(
          child: Padding(
            padding: context.paddingSymmetric(horizontal: 8.0),
            child: toggleWidget,
          ),
        ),
      if (page.filterButton != null)
        Padding(
          padding: context.paddingOnly(end: 8.0, start: 8),
          child: page.filterButton ?? const SizedBox.shrink(),
        ),
      if (showTableModeToggle)
        Flexible(
          child: Padding(
            padding: context.paddingOnly(start: 8.0),
            child: Obx(
              () => ViewToggle(
                isTableView: page.isTableView.value,
                onToggle: (v) => page.isTableView.value = v,
              ),
            ),
          ),
        ),
      if (page.togglePosition == TogglePosition.end && toggleWidget != null)
        Flexible(
          child: Padding(
            padding: context.paddingOnly(start: 8.0),
            child: toggleWidget,
          ),
        ),
      if (page.endActionButton != null) page.endActionButton ?? const SizedBox.shrink(),
      8.wBox,
    ];

    if (isNarrow) {
      return Padding(
        padding: context.paddingSymmetric(
          horizontal: 8.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: leftWidgets),
            4.hBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: rightWidgets,
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: context.paddingSymmetric(
        horizontal: 8.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Row(mainAxisSize: MainAxisSize.min, children: leftWidgets),
          ),
          Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: rightWidgets,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentTabbedTabsToggleSection<S> extends StatelessWidget {
  final ContentTabbedLandscapeViewPage<S> page;

  const _ContentTabbedTabsToggleSection({required this.page});

  @override
  Widget build(BuildContext context) {
    return page.tabController != null
        ? ListenableBuilder(
            listenable: page.tabController!,
            builder: (_, __) {
              final selectedIndex = page.tabController!.index;
              final S selectedItem = page.tabs[selectedIndex];
              return ToggleSwitch<S>(
                initialItem: selectedItem,
                items: page.tabs,
                useNewStyle: true,
                isCompact: true,
                isScrollable: true,
                fontWeight: page.tabFontWeight,
                suffixChipFontWeight: page.tabSuffixChipFontWeight,
                onUnselectedColor: page.tabOnUnselectedColor,
                suffixChipColor: page.tabSuffixChipColor,
                suffixChipFontSize: page.tabSuffixChipFontSize,
                minItemWidth: page.tabMinItemWidth,
                borderRadius: page.tabBorderRadius,
                itemPadding: page.tabItemPadding,
                padding: page.tabPadding,
                itemLabel: page.tabLabelBuilder,
                fontSize: page.tabItemFontSize,
                isItemSelected: (value) => selectedItem == value,
                onItemChanged: (value) {
                  if (value == null) return;
                  final newIndex = page.tabs.indexOf(value);
                  if (newIndex != -1) page.tabController?.animateTo(newIndex);
                },
                suffixChipLabel: page.suffixChipLabelBuilder,
              );
            },
          )
        : page.selectedTabRx != null
        ? Obx(() {
            final S? selectedItem = page.selectedTabRx?.value;

            return ToggleSwitch<S>(
              initialItem: selectedItem,
              items: page.tabs,
              useNewStyle: true,
              isCompact: true,
              isScrollable: true,
              onUnselectedColor: page.tabOnUnselectedColor,
              borderRadius: page.tabBorderRadius,
              itemPadding: page.tabItemPadding,
              padding: page.tabPadding,
              itemLabel: page.tabLabelBuilder,
              isItemSelected: (value) => selectedItem == value,
              onItemChanged: (value) {
                if (value == null || value == selectedItem) return;
                page.selectedTabRx?.value = value;
              },
              suffixChipLabel: page.suffixChipLabelBuilder,
            );
          })
        : const SizedBox.shrink();
  }
}

// ---------------------------------------------------------------------------
// Toggle Position Enum
// ---------------------------------------------------------------------------

enum TogglePosition { afterTitle, afterSearch, end, belowHeader }
