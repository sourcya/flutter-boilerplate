import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../../core/utils/app_utils.dart';

Widget buildSettingsDialog<T>({
  required String title,
  required List<T> items,
  required void Function(T item) onItemSelected,
  required String Function(T item) itemName,
  String Function(T item)? itemIcon,
  Widget? Function(T item)? itemIconWidget,
  required bool Function(T item) isItemSelected,
}) {
  return Center(
    child: Card(
      elevation: 1,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      color:colorScheme.surface,
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
                  color:colorScheme.onBackground,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: items
                  .map((item) => OptimizedCard(
                color:colorScheme.surface,
                elevation: 4,
                      margin:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                      padding: EdgeInsets.symmetric(
                          horizontal: 2.w, vertical: 2.h,),
                      shouldShowCustomShadow: !AppUtils.isDarkMode(),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                 child: Obx(() {
                        return ListTile(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 6.w, vertical: 6.h,),
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
                                    itemIcon(item),
                                  ),
                                )
                              : itemIconWidget != null
                                  ? Container(
                                      width: 36.w,
                                      height: 36.h,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.w,),
                                      alignment: Alignment.center,
                                      child: itemIconWidget(item),
                                    )
                                  : null,
                          title: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 4.h,),
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
