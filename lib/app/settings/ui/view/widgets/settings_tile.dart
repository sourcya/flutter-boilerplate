import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/colors/app_color_scheme.dart';

Widget buildSettingsTile({
  required String title,
  String? subtitle,
  IconData? icon,
  String? svgIcon,
  required void Function() onTap,
  bool? isSelected,
  void Function(bool?)? onSelectionChanged,
}) {
  return InkWell(
    onTap: onTap,
    splashColor: colorScheme.primary,
    child: OptimizedCard(
      margin: AppUtils.isDarkMode()? EdgeInsets.symmetric(horizontal: 8.w, vertical:4.h):  EdgeInsets.symmetric(horizontal: 6.w, vertical:3.h),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical:2.h),
      shouldShowCustomShadow: !AppUtils.isDarkMode(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      color:colorScheme.surface,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.0.h),
        child:
        Row(
            children: [
              IconViewer(
                icon: icon,
                svgIcon: svgIcon,
                iconColor: colorScheme.primary,
                iconSize: 20.r,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          right: 2.w, left: 2.w, top: 4.h, bottom: 2.h,),
                      child: Text(title,
                        style: TextStyle(
                          color: colorScheme.onBackground,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),

                    if(subtitle != null)
                      Container(
                        padding: EdgeInsets.only(right: 2.w, left: 2.w, top: 4
                            .h, bottom: 4.h,),
                        child: Text(subtitle,
                          style: TextStyle(
                            color: colorScheme.subtitleTextColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),

                  ],
                ),
              ),

              if(isSelected != null)
                Checkbox(
                  value: isSelected,
                  fillColor: const MaterialStatePropertyAll(Colors.transparent),
                  activeColor: colorScheme.onBackground,
                  checkColor: colorScheme.primary,
                  onChanged: onSelectionChanged,
                ),
              SizedBox(width: 10.w),
            ],

          ),
      ),
    ),
  );
}
