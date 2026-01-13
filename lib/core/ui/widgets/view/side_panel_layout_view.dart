part of '../../ui.dart';

class SidePanelLayoutView<T> extends StatelessWidget {
  final String title;

  // Core
  final Rx<T> selectedItem;
  final List<T> items;

  // Builders
  final Widget Function(BuildContext context, T item) contentBuilder;
  final Widget Function(BuildContext context, T item, bool selected)?
      sideItemBuilder;

  // Header
  final bool showSearch;
  final TextEditingController? searchController;
  final Function(String)? onSearchChanged;
  final Widget? filterButton;
  final Widget? endActionButton;

  // Optional Sidebar Widget (like stepper)
  final Widget Function(BuildContext context, T selectedItem, List<T> items)?
      sidebarBuilder;

  final List<BreadcrumbItem> breadcrumbs;

  const SidePanelLayoutView({
    super.key,
    required this.title,
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
  });

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: title,
      actions: const [],
      breadcrumbs: breadcrumbs,
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12.r)),
          _buildHeader(context),
          SliverToBoxAdapter(child: SizedBox(height: 8.r)),
          SliverToBoxAdapter(child: _buildSidePanelLayout(context)),
          SliverToBoxAdapter(
            child: SizedBox(height: 16.r + context.mediaQuery.padding.bottom),
          ),
        ],
      ),
    );
  }

  // -------------------------------
  // Header
  // -------------------------------
  Widget _buildHeader(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.r),
        child: Row(
          children: [
            8.boxR,
            CustomText(title, fontSize: 20.sp, fontWeight: FontWeight.w500),
            const Spacer(),
            if (showSearch) _buildSearchBar(context),
            if (filterButton != null) filterButton!,
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
        prefix: Icon(Icons.search, color: context.colors.onSurface),
        fillColor: context.colors.cardColor,
        hint: AppTrans.search.tr(context: context),
        contentPadding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
      ),
    );
  }

  // -------------------------------
  // SidePanel Layout
  // -------------------------------
  Widget _buildSidePanelLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(width: 12.r),
        // Sidebar (custom or default)
        if (sidebarBuilder != null)
          Obx(() {
            final selected = selectedItem.value;
            return sidebarBuilder!(context, selected, items);
          })
        else
          _buildDefaultSidebar(context),
        SizedBox(width: 16.r),
        // Content
        Expanded(child: _buildContentArea(context)),
        SizedBox(width: 12.r),
      ],
    );
  }

  // -------------------------------
  // Default Sidebar
  // -------------------------------
  Widget _buildDefaultSidebar(BuildContext context) {
    return Container(
      width: context.width * .16,
      padding: EdgeInsets.symmetric(vertical: 20.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return AnimatedContainer(
            duration: 250.ms,
            margin: EdgeInsets.only(bottom: 14.r),
            child: Obx(() {
              final isSelected = selectedItem.value == item;
              return InkWell(
                borderRadius: BorderRadius.circular(9999),
                onTap: () => selectedItem.value = item,
                child: sideItemBuilder != null
                    ? sideItemBuilder!(context, item, isSelected)
                    : Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 12.r,
                          horizontal: 12.r,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected ? context.colors.primary : null,
                          borderRadius: BorderRadius.circular(
                            isSelected ? 9999 : 8.r,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              size: 16.r,
                              color: isSelected
                                  ? Colors.white
                                  : context.colors.onSurface,
                            ),
                            SizedBox(width: 8.r),
                            Expanded(child: Text(item.toString())),
                          ],
                        ),
                      ),
              );
            }),
          ).animate().fadeIn(duration: 250.ms).slideX(
                begin: -0.1,
                end: 0,
                duration: 250.ms,
                delay: (60 * index).ms,
              );
        }).toList(),
      ),
    );
  }

  // -------------------------------
  // Content Area
  // -------------------------------
  Widget _buildContentArea(BuildContext context) {
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
              if (currentChild != null) currentChild
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
            margin: EdgeInsetsDirectional.only(end: 24.r),
            color: context.colors.cardColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: context.colors.borderColor,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            key: ValueKey(selected),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 16.r),
              child: contentBuilder(context, selected),
            ),
          );
        }),
      ),
    );
  }
}
