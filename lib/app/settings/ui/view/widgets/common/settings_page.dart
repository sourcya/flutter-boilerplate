part of '../../../imports/settings_imports.dart';

class BuildSettingsPage<T> extends StatefulWidget {
  final List<T> items;
  final void Function(T item) onItemSelected;
  final String Function(T item) itemName;
  final String Function(T item)? itemIcon;
  final Widget? Function(T item)? itemIconWidget;
  final bool Function(T item) isItemSelected;

  const BuildSettingsPage({
    super.key,
    required this.items,
    required this.onItemSelected,
    required this.itemName,
    this.itemIcon,
    this.itemIconWidget,
    required this.isItemSelected,
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
      ),
      context: context,
      onClosePressed: onCloseButtonPressed,
      onPreviousPressed: onBackButtonPressed,
      showPreviousButton: RxBool(showPreviousButton),
    );
  }
}

class _BuildSettingsPageState<T> extends State<BuildSettingsPage<T>> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(vertical: 8.r, horizontal: 2.r),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          widget.items
              .map(
                (item) => InkWell(
                  onTap: () => widget.onItemSelected(item),
                  borderRadius: BorderRadius.circular(8.r),
                  child: Obx(() {
                    return CustomCard(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        side: widget.isItemSelected(item)
                            ? BorderSide(
                                color: context.colors.primary,
                                width: 2,
                              )
                            : BorderSide.none,
                      ),
                      isChild: true,
                      elevation: AppUtils.isDarkMode() ? 12 : 0,
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 4.h,
                        ),
                        trailing: widget.isItemSelected(item)
                            ? Icon(
                                Icons.check,
                                color: context.colors.primary,
                                size: 20.r,
                              )
                            : null,
                        leading: widget.itemIcon != null
                            ? Container(
                                width: 36.w,
                                height: 36.h,
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                alignment: Alignment.center,
                                child: ImageViewer.svgAsset(
                                  widget.itemIcon!(item),
                                ),
                              )
                            : widget.itemIconWidget != null
                                ? Container(
                                    width: 36.w,
                                    height: 36.h,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                    ),
                                    alignment: Alignment.center,
                                    child: widget.itemIconWidget!(item),
                                  )
                                : null,
                        title: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.r,
                            vertical: 4.r,
                          ),
                          child: CustomText(
                            widget.itemName(item),
                            color: context.colors.primary,
                            fontSize: 15.sp,
                            font: fontFamilyBasedOnText(widget.itemName(item)),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
