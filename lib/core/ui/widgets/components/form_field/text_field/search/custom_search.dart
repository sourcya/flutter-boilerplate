part of '../../../../../ui.dart';

/// A unified search component that handles both iOS (Cupertino) and Android (Material) platforms.
///
/// This component provides a consistent search experience across platforms while respecting
/// platform-specific design guidelines. It uses [CupertinoSearchTextField] on iOS and
/// [SearchBar] on Android.
///
/// The widget accepts the following parameters:
/// - [controller]: Controller for the search text field
/// - [onChanged]: Callback when the search text changes
/// - [onSuffixTap]: Optional callback when the clear button is tapped
/// - [hint]: Optional hint text to display when the field is empty
/// - [maxWidth]: Optional maximum width constraint for the search bar
class CustomSearch extends StatelessWidget {
  /// Optional title for the search field
  final String? title;

  /// Controller for the search text field
  final TextEditingController controller;

  /// Callback when the search text changes
  final ValueChanged<String>? onChanged;

  /// Optional callback when the clear button is tapped
  final VoidCallback? onSuffixTap;

  /// Optional hint text to display when the field is empty
  final String? hint;

  /// Optional maximum width constraint for the search bar
  final double? maxWidth;

  /// Border radius for the search field
  final double borderRadius;

  /// Optional margin for the search bar
  final EdgeInsetsGeometry? margin;

  /// Optional content padding for the search field
  final EdgeInsetsGeometry? contentPadding;

  /// Text spans for the title, allowing styled text with multiple spans.
  final List<TextSpan>? titleSpans;

  /// The focus node for the search field
  final FocusNode? focusNode;

  /// Callback when the search field is tapped
  final VoidCallback? onTap;

  /// Callback when the search is submitted
  final ValueChanged<String>? onSubmitted;

  /// Fill color for the search field
  final Color? fillColor;

  /// BoxConstraints for the search field
  final BoxConstraints? constraints;

  const CustomSearch({
    super.key,
    required this.controller,
    this.onChanged,
    this.onSuffixTap,
    this.hint = AppTrans.search,
    this.margin,
    this.maxWidth,
    this.borderRadius = 10.0,
    this.contentPadding,
    this.titleSpans,
    this.focusNode,
    this.onTap,
    this.onSubmitted,
    this.fillColor,
    this.title,
    this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      constraints: BoxConstraints(maxWidth: maxWidth ?? 200.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (titleSpans != null || title != null) ...[
            if (titleSpans != null)
              RichText(
                text: TextSpan(children: titleSpans),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
            else
              CustomText(
                title ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                color: context.colors.cardForeground,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                height: 1.43,
              ),
            8.hBox,
          ],
          ConstrainedBox(
            constraints: constraints ?? BoxConstraints(maxHeight: 48.r),
            child: PlayxPlatform.isCupertino
                ? _CustomSearchIosBar(
                    controller: controller,
                    focusNode: focusNode,
                    onTap: onTap,
                    onSubmitted: onSubmitted,
                    hint: hint,
                    contentPadding: contentPadding,
                    onChanged: onChanged,
                    onSuffixTap: onSuffixTap,
                    borderRadius: borderRadius,
                    fillColor: fillColor,
                  )
                : _CustomSearchMaterialBar(
                    controller: controller,
                    focusNode: focusNode,
                    onTap: onTap,
                    onSubmitted: onSubmitted,
                    contentPadding: contentPadding,
                    borderRadius: borderRadius,
                    onChanged: onChanged,
                    onSuffixTap: onSuffixTap,
                    fillColor: fillColor,
                    hint: hint,
                  ),
          ),
        ],
      ),
    );
  }
}

class _CustomSearchIosBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onSubmitted;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixTap;
  final double borderRadius;
  final Color? fillColor;

  const _CustomSearchIosBar({
    required this.controller,
    this.focusNode,
    this.onTap,
    this.onSubmitted,
    this.hint,
    this.contentPadding,
    this.onChanged,
    this.onSuffixTap,
    required this.borderRadius,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoSearchTextField(
      controller: controller,
      focusNode: focusNode,
      onTap: onTap,
      onSubmitted: onSubmitted,
      placeholder: hint?.tr(context: context),
      prefixIcon: IconInfo.svg(
        Asset.icons.search,
        color: context.colors.mutedForeground,
        size: 18.r,
      ).buildIconWidget(),
      placeholderStyle: TextStyle(
        color: context.colors.mutedForeground,
        fontSize: 14.sp,
        fontFamily: fontFamily(context: context),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius.r),
        color: fillColor ?? context.colors.inputBackgroundColor,
        border: Border.all(
          color: context.colors.cardBorderColor,
        ),
      ),
      style: TextStyle(
        color: context.colors.cardForeground,
        fontSize: 15.sp,
        fontFamily: fontFamily(context: context),
      ),
      onChanged: onChanged,
      suffixIcon: Icon(CupertinoIcons.clear_circled_solid, size: 18.r),
      onSuffixTap: () {
        controller.clear();
        onSuffixTap?.call();
        onChanged?.call('');
      },
      padding: contentPadding ?? context.paddingSymmetric(horizontal: 12, vertical: 10),
    );
  }
}

class _CustomSearchMaterialBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final VoidCallback? onTap;
  final ValueChanged<String>? onSubmitted;
  final double borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSuffixTap;
  final Color? fillColor;
  final String? hint;

  const _CustomSearchMaterialBar({
    required this.controller,
    this.focusNode,
    this.onTap,
    this.onSubmitted,
    required this.borderRadius,
    this.contentPadding,
    this.onChanged,
    this.onSuffixTap,
    this.fillColor,
    this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: controller,
      focusNode: focusNode,
      onTap: onTap,
      onSubmitted: onSubmitted,
      onChanged: (String value) {
        onChanged?.call(value);
      },
      hintText: hint?.tr(context: context),
      constraints: BoxConstraints(minHeight: 48.r, maxHeight: 48.r),
      leading: IconInfo.svg(
        Asset.icons.search,
        color: context.colors.subtitleTextColor,
        size: 18.r,
      ).buildIconWidget(),
      trailing: [
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: controller,
          builder:
              (
                BuildContext context,
                TextEditingValue value,
                Widget? child,
              ) {
                return AnimatedVisibility(
                  duration: 250.ms,
                  isVisible: value.text.isNotEmpty,
                  child: IconButton(
                    onPressed: () {
                      controller.clear();
                      onSuffixTap?.call();
                      onChanged?.call('');
                    },
                    icon: Icon(CupertinoIcons.clear_circled_solid, size: 18.r),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(minWidth: 48.r, minHeight: 48.r),
                  ),
                );
              },
        ),
      ],
      backgroundColor: WidgetStatePropertyAll(fillColor ?? context.colors.inputBackgroundColor),
      elevation: const WidgetStatePropertyAll(0),
      shadowColor: const WidgetStatePropertyAll(Colors.transparent),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
      ),
      side: WidgetStatePropertyAll(BorderSide(color: context.colors.cardBorderColor)),
      padding: WidgetStatePropertyAll(
        contentPadding ?? context.paddingSymmetric(horizontal: 12 /* , vertical: 10 */),
      ),
      textStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: Dimens.fieldTextSize,
          color: context.colors.onSurface,
          fontFamily: fontFamily(context: context),
        ),
      ),
      hintStyle: WidgetStatePropertyAll(
        TextStyle(
          fontSize: 13.sp,
          color: context.colors.subtitleTextColor,
          fontFamily: fontFamily(context: context),
        ),
      ),
    );
  }
}
