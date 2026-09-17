part of '../../ui.dart';

class CustomDropDown<T> extends StatelessWidget {
  final List<T> items;
  final T? selectedItem;
  final String? hint;
  final void Function(T?)? onSelected;
  final String Function(T)? labelBuilder;
  final String? Function(T)? subtitleBuilder;

  final String? Function(T)? iconUrlBuilder;
  final Widget Function(T)? itemBuilder;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Widget? hintWidget;
  final Widget? icon;
  final Offset offset;
  final Widget? bottomWidget;
  final VoidCallback? onBottomWidgetTap;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;

  const CustomDropDown({
    required this.items,
    this.selectedItem,
    this.hint,
    this.hintWidget,
    this.icon,
    this.offset = Offset.zero,
    this.onSelected,
    this.labelBuilder,
    this.subtitleBuilder,
    this.iconUrlBuilder,
    this.itemBuilder,
    this.contentPadding,
    this.padding,
    this.color,
    this.bottomWidget,
    this.onBottomWidgetTap,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _stateShell(
        context,
        child: Row(
          children: [
            SizedBox(
              width: 18.r,
              height: 18.r,
              child: CenterLoading.adaptive(color: context.colors.primary),
            ),
            12.wBox,
            CustomText(
              AppTrans.loadingStatusLoading,
              color: context.colors.subtitleTextColor,
            ),
          ],
        ),
      );
    }
    if (errorMessage != null) {
      return _stateShell(
        context,
        child: Row(
          children: [
            Expanded(
              child: CustomText(
                errorMessage!,
                color: context.colors.error,
                maxLines: 1,
                textOverflow: TextOverflow.ellipsis,
              ),
            ),
            if (onRetry != null)
              TextButton(
                onPressed: onRetry,
                child: CustomText(AppTrans.retryText, color: context.colors.primary),
              ),
          ],
        ),
      );
    }
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint: hintWidget ??
            CustomText(
              hint ?? '',
              fontSize: 14.sp,
              color: context.colors.subtitleTextColor,
            ),
        items: [
          ..._itemsWidgets(context),
          if (bottomWidget != null)
            DropdownMenuItem<T>(
              enabled: false,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const DashedLine(),
                  SizedBox(height: 8.r),
                  InkWell(
                    borderRadius: BorderRadius.circular(14.r),
                    onTap: onBottomWidgetTap,
                    child: bottomWidget,
                  ),
                ],
              ),
            ),
        ],
        value: selectedItem,
        onChanged: (value) {
          onSelected?.call(value);
        },
        buttonStyleData: ButtonStyleData(
          // height: 50,
          // width: 100.r,
          padding: padding ??
              EdgeInsetsDirectional.only(
                start: 4.r,
                end: 14.r,
                top: 4.r,
                bottom: 4.r,
              ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: color ?? context.colors.cardBorderColor,
            ),
            color: context.colors.surface,
          ),
          // elevation: 2,
        ),
        iconStyleData: IconStyleData(
          iconEnabledColor: context.colors.primary,
          iconDisabledColor: context.colors.mutedForeground,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400.r,
          offset: offset,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: context.colors.surface,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: contentPadding ?? context.paddingOnly(start: 14, end: 14),
        ),
      ),
    );
  }

  Iterable<DropdownMenuItem<T>> _itemsWidgets(BuildContext context) {
    return items.map(
      (T item) => DropdownMenuItem<T>(
        value: item,
        child: itemBuilder?.call(item) ??
            Row(
              children: [
                if (iconUrlBuilder != null) ...[
                  SizedBox(
                    width: 28.r,
                    height: 28.r,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(14.r),
                      child: CachedNetworkImage(
                        imageUrl: iconUrlBuilder?.call(item) ?? '',
                        fit: BoxFit.cover,
                        // errorWidget: (_, __, ___) => Padding(
                        //   padding: const EdgeInsets.all(4.0),
                        //   child: ImageViewer.svgAsset(
                        //     Assets.images.placeholder,
                        //   ),
                        // ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.r),
                ],
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 4.r),
                      CustomText(
                        labelBuilder?.call(item) ?? '',
                        fontSize: 14.sp,
                        color: context.colors.onSurface,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                      ),
                      if (subtitleBuilder != null) ...[
                        SizedBox(height: 4.r),
                        CustomText(
                          subtitleBuilder?.call(item) ?? '',
                          fontSize: 12.sp,
                          color: context.colors.subtitleTextColor,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
      ),
    );
  }

  Widget _stateShell(BuildContext context, {required Widget child}) {
    return Container(
      width: double.infinity,
      padding: padding ??
          EdgeInsetsDirectional.only(
            start: 12.r,
            end: 14.r,
            top: 12.r,
            bottom: 12.r,
          ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color ?? context.colors.cardBorderColor),
        color: context.colors.surface,
      ),
      child: child,
    );
  }
}
