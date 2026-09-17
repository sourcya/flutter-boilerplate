part of '../../../imports/settings_imports.dart';

class BuildSettingsDialog<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final void Function(T item) onItemSelected;
  final String Function(T item) itemName;
  final String Function(T item)? itemIcon;
  final Widget? Function(T item)? itemIconWidget;
  final bool Function(T item) isItemSelected;

  const BuildSettingsDialog({
    super.key,
    required this.title,
    required this.items,
    required this.onItemSelected,
    required this.itemName,
    this.itemIcon,
    this.itemIconWidget,
    required this.isItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: context.paddingAll(12.0),
            child: CustomText(
              title,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
              color: context.colors.onSurface,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: items
                .map(
                  (item) => CustomCard(
                    margin:
                        context.paddingSymmetric(horizontal: 3, vertical: 4),
                    padding: context.paddingSymmetric(horizontal: 2, vertical: 2),
                    child: Obx(() {
                      return ListTile(
                        contentPadding: context.paddingSymmetric(horizontal: 6, vertical: 6),
                        trailing: isItemSelected(item)
                            ? Icon(
                                Icons.check,
                                color: context.colors.primary,
                                size: 20.r,
                              )
                            : null,
                        onTap: () => onItemSelected(item),
                        leading: itemIcon != null
                            ? Container(
                                width: 36.w,
                                height: 36.h,
                                padding: context.paddingSymmetric(horizontal: 6),
                                alignment: Alignment.center,
                                child: ImageViewer.svgAsset(
                                  itemIcon!(item),
                                ),
                              )
                            : itemIconWidget != null
                                ? Container(
                                    width: 36.w,
                                    height: 36.h,
                                    padding: context.paddingSymmetric(horizontal: 6),
                                    alignment: Alignment.center,
                                    child: itemIconWidget!(item),
                                  )
                                : null,
                        title: Padding(
                          padding: context.paddingSymmetric(horizontal: 4, vertical: 4),
                          child: CustomText(
                            itemName(item),
                            isTranslatable: false,
                            fontSize: 14.sp,
                            color: context.colors.onSurface,
                          ),
                        ),
                      );
                    }),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
