import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_color_scheme.dart';
import '../../utils/app_utils.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  const CustomCard({this.padding, required this.child, this.margin});

  @override
  Widget build(BuildContext context) {
    return OptimizedCard(
      margin: margin ??
          (AppUtils.isDarkMode()
              ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)
              : EdgeInsets.symmetric(horizontal: 6.w, vertical: 3.h)),
      padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
      shouldShowCustomShadow: !AppUtils.isDarkMode(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.r),
      ),
      color: colorScheme.surface,
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
        child: child,
      ),
    );
  }
}
