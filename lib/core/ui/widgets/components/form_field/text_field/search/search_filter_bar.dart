part of '../../../../../ui.dart';

/// A unified search and filter bar component that can be used across the app.
///
/// This component provides a consistent search and filter experience with:
/// - A search input field
/// - A filter button with customizable callback
/// - Platform-specific styling (iOS/Material)
///
/// The widget accepts the following parameters:
/// - [searchController]: Controller for the search text field
/// - [onSearchChanged]: Callback when the search text changes
/// - [onFilterTap]: Optional callback when the filter button is tapped
/// - [searchHintText]: Optional hint text for the search field
/// - [filterHintText]: Optional hint text for the filter button
/// - [showFilter]: Whether to show the filter button (default: true)
/// - [padding]: Optional padding for the container
class SearchFilterBar extends StatelessWidget {
  /// Controller for the search text field
  final TextEditingController searchController;

  /// Callback when the search text changes
  final ValueChanged<String>? onSearchChanged;

  /// Optional callback when the filter button is tapped
  final VoidCallback? onFilterTap;

  /// Optional hint text for the search field
  final String searchHintText;

  /// Optional hint text for the filter button
  final String? filterHintText;

  /// Whether to show the filter button
  final bool showFilter;

  /// Whether the filter button should use the active (applied filters) style.
  final bool isFilterActive;

  /// BoxConstraints for the Search
  final BoxConstraints? searchBoxConstraints;

  /// Optional padding for the container
  final EdgeInsetsGeometry? padding;

  const SearchFilterBar({
    super.key,
    required this.searchController,
    this.onSearchChanged,
    this.onFilterTap,
    this.searchHintText = AppTrans.search,
    this.filterHintText,
    this.showFilter = true,
    this.isFilterActive = false,
    this.padding,
    this.searchBoxConstraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: searchBoxConstraints,
      padding: padding ?? context.paddingAll(16),
      child: Row(
        spacing: 8,
        children: [
          Expanded(
            child: _SearchFilterBarField(
              controller: searchController,
              onChanged: onSearchChanged,
              hint: searchHintText,
            ),
          ),
          if (showFilter)
            SearchFilterBarFilterButton(
              onFilterTap: onFilterTap,
              isActive: isFilterActive,
            ),
        ],
      ),
    );
  }
}

class _SearchFilterBarField extends StatelessWidget {
  const _SearchFilterBarField({
    required this.controller,
    this.onChanged,
    required this.hint,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String hint;

  @override
  Widget build(BuildContext context) {
    final hintStyle = TextStyle(
      color: context.colors.mutedForeground,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      height: 1.43,
      fontFamily: fontFamily(context: context),
    );
    final textStyle = TextStyle(
      color: context.colors.cardForeground,
      fontSize: 14.sp,
      fontWeight: FontWeight.w400,
      height: 1.43,
      fontFamily: fontFamily(context: context),
    );

    return Container(
      padding: context.paddingSymmetric(horizontal: 12, vertical: 10),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: context.colors.inputBackgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.colors.cardBorderColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        spacing: 8,
        children: [
          IconInfo.svg(
            Asset.icons.search,
            color: context.colors.mutedForeground,
            size: 16.r,
          ).buildIconWidget(),
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: textStyle,
              cursorColor: context.colors.primary,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hint.tr(context: context),
                hintStyle: hintStyle,
              ),
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (context, value, _) {
              if (value.text.isEmpty) return const SizedBox.shrink();
              return GestureDetector(
                onTap: () {
                  controller.clear();
                  onChanged?.call('');
                },
                child: Icon(
                  CupertinoIcons.clear_circled_solid,
                  size: 16.r,
                  color: context.colors.mutedForeground,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class SearchFilterBarFilterButton extends StatelessWidget {
  const SearchFilterBarFilterButton({
    this.onFilterTap,
    this.isActive = false,
  });

  final VoidCallback? onFilterTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return ActionButton.outlined(
      onPressed: onFilterTap,
      backgroundColor: isActive
          ? AppColors.primaryPalette.primary50
          : context.colors.inputBackgroundColor,
      foregroundColor: context.colors.primary,
      borderColor: AppColors.primaryPalette.primary200,
      borderRadius: 12.radius,
      padding: context.paddingAll(12),
      constraints: BoxConstraints.tightFor(width: 40.r, height: 40.r),
      icon: IconInfo.svg(Asset.icons.icFilter).buildIconWidget(
        size: 16.r,
        color: context.colors.primary,
      ),
    );
  }
}
