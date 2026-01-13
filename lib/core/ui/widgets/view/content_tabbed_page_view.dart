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
  final TextEditingController? searchController;
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
  )?
  tablePagingBuilder;

  /// Builds the list/grid view for a tab given an item
  final Widget Function(BuildContext context, dynamic item, int index)? itemPagingBuilder;

  final Widget? topWidget;

  final String emptyMessage;
  final String Function(S)? emptyMessageBuilder;

  final RxBool isTableView;

  final bool addPopScope;

  final Widget Function(Widget child)? toggleSwitchDecorator;

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
    this.searchController,
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
    this.tablePagingBuilder,
    this.itemPagingBuilder,
    this.topWidget,
    this.toggleSwitchDecorator,
    RxBool? isTableView,
    this.addPopScope = false,
  }) : isTableView = isTableView ?? false.obs;

  @override
  Widget build(BuildContext context) {
    final toggleWidgetChild =
        customToggleBuilder?.call(context) ?? (showTabToggle ? _buildTabsToggle(context) : null);

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

          if (isTable) {
            return SizedBox(
              height: context.height * .8,
              child:
                  tablePagingBuilder?.call(context, pc) ??
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

    return CustomScaffold(
      title: title,
      addPopScope: addPopScope,
      child: RefreshIndicator(
        onRefresh: onRefresh ?? () async {},
        child: Column(
          children: [
            12.r.boxR,
            if (topWidget != null) topWidget!,
            ValueListenableBuilder(
              valueListenable: AppController.instance.drawerController,
              builder: (context, value, child) {
                return _buildHeader(
                  context,
                  toggleWidget: toggleWidget,
                  drawerControllerValue: value,
                );
              },
            ),
            if (togglePosition == TogglePosition.belowHeader && toggleWidget != null)
              Padding(
                padding: EdgeInsets.only(left: 8.r),
                child: toggleWidget,
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
        ),
      ),
    );
  }

  // ---------------- HEADER ----------------
  Widget _buildHeader(
    BuildContext context, {
    Widget? toggleWidget,
    required AdvancedDrawerValue drawerControllerValue,
  }) {
    final showTableModeToggle =
        showTableToggle &&
        contentBuilder == null &&
        ((tableBuilder != null || pagingControllerBuilder != null) &&
            (listBuilder != null || itemPagingBuilder != null));

    final isDrawerOpen = drawerControllerValue.visible;

    // Drawer takes 25% of screen width when open
    final double availableWidth = isDrawerOpen ? context.width * 0.75 : context.width;
    const breakpointWidth = 1100;
    final isNarrow = availableWidth < breakpointWidth;

    // Build the left side: title + toggle if after title
    final leftWidgets = <Widget>[
      CustomText(
        title,
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        textOverflow: TextOverflow.ellipsis,
      ),
      if (togglePosition == TogglePosition.afterTitle && toggleWidget != null)
        Flexible(
          child: Padding(
            padding: EdgeInsetsDirectional.only(start: 8.r),
            child: toggleWidget,
          ),
        ),
      8.r.boxW,
      // const Spacer(),
    ];

    // Build right-side widgets (search, filter, table toggle, endActionButton, toggle after search/end)
    final rightWidgets = <Widget>[
      if (showSearch) SizedBox(child: _buildSearchBar(context)),
      if (togglePosition == TogglePosition.afterSearch && toggleWidget != null)
        Flexible(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.r),
            child: toggleWidget,
          ),
        ),
      if (filterButton != null) filterButton!,
      if (showTableModeToggle)
        Flexible(
          child: Obx(
            () => ViewToggle(
              isTableView: isTableView.value,
              onToggle: (v) => isTableView.value = v,
            ),
          ),
        ),
      if (togglePosition == TogglePosition.end && toggleWidget != null)
        Flexible(
          child: Padding(
            padding: EdgeInsets.only(left: 8.r),
            child: toggleWidget,
          ),
        ),
      if (endActionButton != null) endActionButton!,
    ];

    if (isNarrow) {
      // Two-row layout for narrow screens
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: leftWidgets),
            SizedBox(height: 4.r),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: rightWidgets),
          ],
        ),
      );
    } else {
      // Single row layout for wide screens
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
        child: Row(
          children: [
            4.boxW,
            ...leftWidgets,
            (context.width < 480 || context.height < 480 ? 40.r : 80.r).boxW,
            Row(mainAxisSize: MainAxisSize.min, children: rightWidgets),
          ],
        ),
      );
    }
  }

  // ---------------- SEARCH ----------------
  Widget _buildSearchBar(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.r),
      margin: EdgeInsets.symmetric(horizontal: 4.r),
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
              size: 18.r,
            ).buildIconWidget(),
          ],
        ),
        fillColor: context.colors.cardColor,
        hint: AppTrans.search.tr(context: context),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
      ),
    );
  }

  // ---------------- TAB TOGGLE ----------------
  Widget _buildTabsToggle(BuildContext context) {
    return tabController != null
        ? ListenableBuilder(
            listenable: tabController!,
            builder: (_, __) {
              final selectedIndex = tabController!.index;
              final S selectedItem = tabs[selectedIndex];
              return ToggleSwitch<S>(
                // width: context.width > 840 ? context.width * .5 : null,
                initialItem: selectedItem,
                items: tabs,
                useNewStyle: true,
                isCompact: true,
                itemLabel: tabLabelBuilder,
                isItemSelected: (value) => selectedItem == value,
                onItemChanged: (value) {
                  if (value == null) return;
                  final newIndex = tabs.indexOf(value);
                  if (newIndex != -1) tabController?.animateTo(newIndex);
                },
              );
            },
          )
        : selectedTabRx != null
        ? Obx(() {
            final S? selectedItem = selectedTabRx?.value;

            return ToggleSwitch<S>(
              // width: context.width > 840 ? context.width * .5 : null,
              initialItem: selectedItem,
              items: tabs,
              useNewStyle: true,
              isCompact: true,
              itemLabel: tabLabelBuilder,
              isItemSelected: (value) => selectedItem == value,
              onItemChanged: (value) {
                if (value == null || value == selectedItem) return;
                selectedTabRx?.value = value;
              },
            );
          })
        : const SizedBox.shrink();
  }
}

// ---------------------------------------------------------------------------
// Toggle Position Enum
// ---------------------------------------------------------------------------

enum TogglePosition { afterTitle, afterSearch, end, belowHeader }
