part of '../../imports/settings_imports.dart';

class SettingsDialog<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final void Function(T item) onItemSelected;
  final String Function(T item) itemName;
  final String Function(T item)? itemIcon;
  final Widget? Function(T item)? itemIconWidget;
  final bool Function(T item) isItemSelected;

  const SettingsDialog({
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
    return  Center(
      child: Card(
        elevation: 1,
        clipBehavior: Clip.hardEdge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        color: colorScheme.surface,
        margin: EdgeInsets.all(8.r),
        child: Padding(
          padding: EdgeInsets.all(8.0.r),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.all(12.0.r),
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                    color: colorScheme.onBackground,
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: items
                    .map(
                      (item) => OptimizedCard(
                    color: colorScheme.surface,
                    elevation: 4,
                    margin:
                    EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 2.h,
                    ),
                    shouldShowCustomShadow: !AppUtils.isDarkMode(),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Obx(() {
                      return ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 6.h,
                        ),
                        trailing: isItemSelected(item)
                            ? Icon(
                          Icons.check,
                          color: colorScheme.primary,
                          size: 20.r,
                        )
                            : null,
                        onTap: () => onItemSelected(item),
                        leading: itemIcon != null
                            ? Container(
                          width: 36.w,
                          height: 36.h,
                          padding:
                          EdgeInsets.symmetric(horizontal: 6.w),
                          alignment: Alignment.center,
                          child: ImageViewer.svgAsset(
                            itemIcon!.call(item),
                          ),
                        )
                            : itemIconWidget != null
                            ? Container(
                          width: 36.w,
                          height: 36.h,
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                          ),
                          alignment: Alignment.center,
                          child: itemIconWidget!(item),
                        )
                            : null,
                        title: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 4.w,
                            vertical: 4.h,
                          ),
                          child: Text(
                            itemName(item),
                            style: TextStyle(
                              color: colorScheme.onBackground,
                              fontSize: 14.sp,
                            ),
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
        ),
      ),
    );
  }
}

