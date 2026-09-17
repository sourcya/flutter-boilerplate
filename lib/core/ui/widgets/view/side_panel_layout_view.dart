part of '../../ui.dart';

class SidePanelLayoutView<T> extends StatelessWidget {
  final String title;

  // Core
  final Rx<T> selectedItem;
  final List<T> items;

  // Builders
  final Widget Function(BuildContext context, T item) contentBuilder;
  final Widget Function(BuildContext context, T item, bool selected)? sideItemBuilder;

  // Header
  final bool showSearch;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final Widget? filterButton;
  final Widget? endActionButton;

  // Optional Sidebar Widget (like stepper)
  final Widget Function(BuildContext context, T selectedItem, List<T> items)? sidebarBuilder;

  final List<BreadcrumbItem> breadcrumbs;
  final bool? attachBreadcrumb;
  final bool showNotificationButton;
  final bool isInitialized;

  /// Gutter around side nav + content card (Figma: 16 on all sides).
  final EdgeInsetsGeometry? sideRowPadding;

  /// Page-level data state; sidebar stays visible while loading (loader in content card only).
  final RxDataState? dataState;

  const SidePanelLayoutView({
    super.key,
    required this.title,
    this.dataState,
    required this.items,
    required this.selectedItem,
    required this.contentBuilder,
    this.sideItemBuilder,
    this.showSearch = false,
    this.searchController,
    this.onSearchChanged,
    this.filterButton,
    this.endActionButton,
    this.sidebarBuilder,
    this.breadcrumbs = const [],
    this.attachBreadcrumb,
    this.showNotificationButton = false,
    this.isInitialized = true,
    this.sideRowPadding,
  });

  @override
  Widget build(BuildContext context) {
    final showInlineHeader = showSearch || filterButton != null || endActionButton != null;

    return CustomScaffold(
      isInitialized: isInitialized,
      title: title,
      bodyAlignment: Alignment.topCenter,
      backgroundColor: context.colors.sidePanelPageBackground,
      breadcrumbs: breadcrumbs,
      attachBreadcrumb: attachBreadcrumb,
      showNotificationButton: showNotificationButton,
      childBuilder: (_) => SafeArea(
        top: false,
        left: false,
        right: false,
        child: Column(
          children: [
            if (showInlineHeader) ...[
              12.hBox,
              _SidePanelHeader(
                title: title,
                showSearch: showSearch,
                searchController: searchController,
                onSearchChanged: onSearchChanged,
                filterButton: filterButton,
                endActionButton: endActionButton,
              ),
              16.hBox,
            ],
            Expanded(
              child: dataState != null
                  ? RxDataStateWidget(
                      rxData: dataState!,
                      onInitial: (_) => _sidePanelRow(context),
                      onLoading: (_) => _sidePanelRow(context),
                      onSuccess: (_) => _sidePanelRow(context),
                    )
                  : _sidePanelRow(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sidePanelRow(BuildContext context) {
    return _SidePanelSideRow<T>(
      items: items,
      selectedItem: selectedItem,
      contentBuilder: contentBuilder,
      sideItemBuilder: sideItemBuilder,
      sidebarBuilder: sidebarBuilder,
      sideRowPadding: sideRowPadding,
      dataState: dataState,
    );
  }
}

class _SidePanelHeader extends StatelessWidget {
  final String title;
  final bool showSearch;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final Widget? filterButton;
  final Widget? endActionButton;

  const _SidePanelHeader({
    required this.title,
    required this.showSearch,
    required this.searchController,
    required this.onSearchChanged,
    required this.filterButton,
    required this.endActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(horizontal: 16),
      child: Row(
        children: [
          if (showSearch)
            _SidePanelSearchBar(
              searchController: searchController,
              onSearchChanged: onSearchChanged,
            ),
          if (filterButton != null) filterButton!,
          if (endActionButton != null) endActionButton!,
        ],
      ),
    );
  }
}

class _SidePanelSearchBar extends StatelessWidget {
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;

  const _SidePanelSearchBar({
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 300.r),
      child: CustomTextField(
        controller: searchController,
        onChanged: onSearchChanged,
        prefix: IconInfo.svg(
          Asset.icons.search,
          size: 24.r,
          color: context.colors.onSurface,
        ).buildIconWidget(),
        fillColor: context.colors.cardColor,
        hint: AppTrans.search.tr(context: context),
        contentPadding: context.paddingSymmetric(horizontal: 8, vertical: 8),
      ),
    );
  }
}

class _SidePanelSideRow<T> extends StatelessWidget {
  final List<T> items;
  final Rx<T> selectedItem;
  final Widget Function(BuildContext context, T item) contentBuilder;
  final Widget Function(BuildContext context, T item, bool selected)? sideItemBuilder;
  final Widget Function(BuildContext context, T selectedItem, List<T> items)? sidebarBuilder;
  final EdgeInsetsGeometry? sideRowPadding;
  final RxDataState? dataState;

  const _SidePanelSideRow({
    required this.items,
    required this.selectedItem,
    required this.contentBuilder,
    required this.sideItemBuilder,
    required this.sidebarBuilder,
    this.dataState,
    this.sideRowPadding,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sideRowPadding ?? context.paddingAll(16),
      child: SizedBox(
        height: context.height,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16.r,
          children: [
            if (sidebarBuilder != null)
              Obx(() {
                final selected = selectedItem.value;
                return sidebarBuilder!(context, selected, items);
              })
            else
              _SidePanelDefaultSidebar<T>(
                items: items,
                selectedItem: selectedItem,
                sideItemBuilder: sideItemBuilder,
              ),
            Expanded(
              child: _SidePanelContentArea<T>(
                selectedItem: selectedItem,
                contentBuilder: contentBuilder,
                dataState: dataState,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SidePanelDefaultSidebar<T> extends StatelessWidget {
  final List<T> items;
  final Rx<T> selectedItem;
  final Widget Function(BuildContext context, T item, bool selected)? sideItemBuilder;

  const _SidePanelDefaultSidebar({
    required this.items,
    required this.selectedItem,
    required this.sideItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 173.r,
      child: Padding(
        padding: context.paddingSymmetric(vertical: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return AnimatedContainer(
                  duration: 250.ms,
                  margin: context.paddingOnly(bottom: 16),
                  child: Obx(() {
                    final isSelected = selectedItem.value == item;
                    return InkWell(
                      borderRadius: BorderRadius.circular(12.r),
                      onTap: () => selectedItem.value = item,
                      child: sideItemBuilder != null
                          ? sideItemBuilder!(context, item, isSelected)
                          : Container(
                              padding: context.paddingSymmetric(
                                vertical: 12,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected ? context.colors.primary : null,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Row(
                                children: [
                                  IconInfo.svg(
                                    Asset.icons.svgIcActive,
                                    size: 16.r,
                                    color: isSelected
                                        ? context.colors.colorScheme.onPrimary
                                        : context.colors.onSurface,
                                  ).buildIconWidget(),
                                  8.wBox,
                                  Expanded(
                                    child: CustomText(
                                      item.toString(),
                                      textStyle: context.bodyMediumTS.copyWith(
                                        color: isSelected
                                            ? context.colors.colorScheme.onPrimary
                                            : context.colors.onSurface,
                                      ),
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                    );
                  }),
                )
                .animate()
                .fadeIn(duration: 250.ms)
                .slideX(
                  begin: -0.1,
                  end: 0,
                  duration: 250.ms,
                  delay: (60 * index).ms,
                );
          }).toList(),
        ),
      ),
    );
  }
}

class _SidePanelContentArea<T> extends StatelessWidget {
  final Rx<T> selectedItem;
  final Widget Function(BuildContext context, T item) contentBuilder;
  final RxDataState? dataState;

  const _SidePanelContentArea({
    required this.selectedItem,
    required this.contentBuilder,
    this.dataState,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: 500.ms,
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: 500.ms,
        switchInCurve: Curves.easeInOutCubic,
        switchOutCurve: Curves.easeInOutCubic,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            alignment: Alignment.topCenter,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        transitionBuilder: (child, anim) {
          final offsetAnim = Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).animate(anim);

          final scaleAnim = Tween<double>(begin: 0.98, end: 1.0).animate(anim);

          return FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: offsetAnim,
              textDirection: TextDirection.ltr,
              child: ScaleTransition(
                alignment: Alignment.topCenter,
                scale: scaleAnim,
                child: child,
              ),
            ),
          );
        },
        child: Obx(() {
          final selected = selectedItem.value;
          return Card(
            margin: EdgeInsets.zero,
            color: context.colors.sidePanelContentSurface,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: context.colors.cardBorderColor,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            key: ValueKey(selected),
            child: Container(
              width: context.width,
              height: double.infinity,
              padding: context.paddingSymmetric(horizontal: 24, vertical: 16),
              child: (dataState?.value.isLoading ?? false)
                  ? const Center(child: CustomLoading())
                  : contentBuilder(context, selected),
            ),
          );
        }),
      ),
    );
  }
}
