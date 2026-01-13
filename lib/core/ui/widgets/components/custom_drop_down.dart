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
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<T>(
        isExpanded: true,
        hint:
            hintWidget ??
            CustomText(hint ?? '', fontSize: 14.sp, color: Colors.grey),
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
          padding:
              padding ??
              EdgeInsetsDirectional.only(
                start: 4.r,
                end: 14.r,
                top: 4.r,
                bottom: 4.r,
              ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: color ?? context.colors.borderColor),
            color: context.colors.cardColor,
          ),
          // elevation: 2,
        ),
        iconStyleData: IconStyleData(
          iconEnabledColor: context.colors.onSurface,
          iconDisabledColor: Colors.grey,
          icon: const Icon(Icons.keyboard_arrow_down),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 400.r,
          offset: offset,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: context.colors.cardColor,
          ),
          // offset: const Offset(-20, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: WidgetStateProperty.all(6),
            thumbVisibility: WidgetStateProperty.all(true),
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          padding: contentPadding ?? EdgeInsets.only(left: 14.r, right: 14.r),
        ),
      ),
    );
  }

  Iterable<DropdownMenuItem<T>> _itemsWidgets(BuildContext context) {
    return items.map(
      (T item) => DropdownMenuItem<T>(
        value: item,
        child:
            itemBuilder?.call(item) ??
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
                      // SizedBox(height: 4.r),
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
}
