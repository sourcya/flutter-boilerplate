part of '../../../imports/settings_imports.dart';

class BuildSettingsPage<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T item) onItemSelected;
  final String Function(T item) itemName;
  final String Function(T item)? itemIcon;
  final Widget? Function(T item)? itemIconWidget;
  final bool Function(T item) isItemSelected;
  final String? emptyStateMessage;
  final Widget? emptyStateWidget;

  const BuildSettingsPage({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.itemName,
    this.itemIcon,
    this.itemIconWidget,
    required this.isItemSelected,
    this.emptyStateMessage,
    this.emptyStateWidget,
  });

  @override
  State<BuildSettingsPage<T>> createState() => _BuildSettingsPageState<T>();

  static SliverWoltModalSheetPage buildModalPage<T>({
    required String title,
    required List<T> items,
    required void Function(T item) onItemSelected,
    required String Function(T item) itemName,
    String Function(T item)? itemIcon,
    Widget? Function(T item)? itemIconWidget,
    required bool Function(T item) isItemSelected,
    VoidCallback? onBackButtonPressed,
    VoidCallback? onCloseButtonPressed,
    required BuildContext context,
    bool showPreviousButton = false,
    String? emptyStateMessage,
    Widget? emptyStateWidget,
  }) {
    return CustomModal.buildCustomModalPage(
      title: title,
      body: BuildSettingsPage(
        items: items,
        onItemSelected: onItemSelected,
        itemName: itemName,
        itemIcon: itemIcon,
        itemIconWidget: itemIconWidget,
        isItemSelected: isItemSelected,
        emptyStateMessage: emptyStateMessage,
        emptyStateWidget: emptyStateWidget,
      ),
      context: context,
      onClosePressed: onCloseButtonPressed,
      onPreviousPressed: onBackButtonPressed,
      showPreviousButton: RxBool(showPreviousButton),
    );
  }
}

class _BuildSettingsPageState<T> extends State<BuildSettingsPage<T>> {
  // For handling haptic feedback
  final HapticFeedbackManager _hapticFeedback = HapticFeedbackManager();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Use MediaQuery for responsive screen width (sliver-compatible)
    final screenWidth = context.mediaQuery.size.width;
    // Adaptive padding based on screen width (responsive)
    final horizontalPadding = screenWidth < 600
        ? 16.r
        : (screenWidth < 1200
            ? 24.r
            : 32.r); // Small: 16, Medium: 24, Large: 32
    final verticalPadding = 8.r;

    return SliverPadding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      sliver: widget.items.isEmpty
          ? _buildEmptyState(colorScheme, isDark)
          : SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final item = widget.items[index];
                  return AnimatedOpacity(
                    opacity: 1.0,
                    duration: const Duration(
                        milliseconds: 200), // Subtle animation for UX
                    child: _buildListItem(
                        item, index, colorScheme, isDark, screenWidth),
                  );
                },
                childCount: widget.items.length,
              ),
            ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, bool isDark) {
    // Wrap the empty state in SliverToBoxAdapter to make it sliver-compatible
    return SliverToBoxAdapter(
      child: SizedBox(
        height: context.mediaQuery.size.height * 0.5,
        child: Center(
          child: widget.emptyStateWidget ??
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 64.r,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 16.h),
                  CustomText(
                    widget.emptyStateMessage ?? 'No items available',
                    color: colorScheme.onSurface.withValues(alpha: 0.7),
                    fontSize: 16.sp,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
        ),
      ),
    );
  }

  Widget _buildListItem(T item, int index, ColorScheme colorScheme, bool isDark,
      double screenWidth) {
    final isSelected = widget.isItemSelected(item);

    final itemPadding = screenWidth < 600 ? 8.r : 12.r;
    final bottomPadding = 8.h;

    return Padding(
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
        // elevation: isDark ? 0 : 1,
        child: InkWell(
          onTap: () {
            _hapticFeedback.lightImpact();
            widget.onItemSelected(item);
          },
          borderRadius: BorderRadius.circular(12.r),
          splashColor: colorScheme.primary.withValues(alpha: 0.2),
          highlightColor: colorScheme.primary.withValues(alpha: 0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: isSelected
                  ? Border.all(color: colorScheme.primary, width: 1.5)
                  : null,
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.08)
                  : null,
              gradient: LinearGradient(
                colors: [
                  context.colors.primary.withValues(alpha: 0.1),
                  context.colors.secondary.withValues(alpha: 0.05),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: context.colors.shadow.withValues(alpha: 0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(itemPadding),
              child: Row(
                children: [
                  if (widget.itemIcon != null || widget.itemIconWidget != null)
                    Container(
                      width: 40.r,
                      height: 40.r,
                      margin: EdgeInsets.only(right: 12.r),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? colorScheme.primary.withValues(alpha: 0.1)
                            : colorScheme.surface.withValues(
                                alpha: isDark ? 0.2 : 0.05,
                              ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Center(
                        child: widget.itemIconWidget != null
                            ? widget.itemIconWidget!(item)
                            : ImageViewer.svgAsset(
                                widget.itemIcon!(item),
                                color: isSelected
                                    ? colorScheme.primary
                                    : colorScheme.onSurface.withValues(
                                        alpha: 0.7,
                                      ),
                              ),
                      ),
                    ),

                  // Title section (adaptive text)
                  Expanded(
                    child: CustomText(
                      widget.itemName(item),

                      color: isSelected
                          ? colorScheme.primary
                          : colorScheme.onSurface, // Adaptive text color
                      fontSize: 16.sp,
                      fontWeight:
                          isSelected ? FontWeight.w600 : FontWeight.normal,
                      font: fontFamilyBasedOnText(widget.itemName(item)),
                    ),
                  ),

                  // Selection indicator (more prominent in dark mode)
                  if (isSelected)
                    Padding(
                      padding: EdgeInsets.only(left: 8.r),
                      child: Icon(
                        Icons.check_circle_rounded,
                        color: colorScheme.primary,
                        size: 24.r,
                        shadows: isDark
                            ? [
                                Shadow(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.3),
                                  blurRadius: 2,
                                )
                              ]
                            : null, // Adaptive shadow for visibility
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Helper class for haptic feedback (unchanged)
class HapticFeedbackManager {
  Future<void> lightImpact() async {
    HapticFeedback.lightImpact();
  }
}
