import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_colors.dart';
import '../../utils/app_utils.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final ShapeBorder? shape;
  final double? elevation;
  final EdgeInsetsGeometry? innerCardShadowMargin;
  final double? width;
  final double? height;
  final BorderRadius? shadowBorderRadius;
  final bool? shouldShowCustomShadow;
  final VoidCallback? onPressed;
  final BorderRadius? borderRadius;
  final bool isChild;

  const CustomCard({
    this.padding,
    required this.child,
    this.margin,
    this.color,
    this.shape,
    this.elevation,
    this.innerCardShadowMargin,
    this.width,
    this.height,
    this.shadowBorderRadius,
    this.shouldShowCustomShadow,
    this.onPressed,
    this.borderRadius,
    this.isChild = false,
  });

  @override
  Widget build(BuildContext context) {
    return OptimizedCard(
      width: width,
      height: height,
      margin: margin ??
          (AppUtils.isDarkMode()
              ? EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r)
              : EdgeInsets.symmetric(horizontal: 6.r, vertical: 4.r)),
      shouldShowCustomShadow: shouldShowCustomShadow ?? !AppUtils.isDarkMode(),
      elevation: elevation ?? (AppUtils.isDarkMode() ? 4 : 0),
      color: color ??
          (AppUtils.isDarkMode()
              ? isChild
                  ? context.colors.surfaceContainerHighest
                  : context.colors.surfaceContainerHigh
              : context.colors.surface),
      innerCardShadowMargin: innerCardShadowMargin,
      shadowBorderRadius: shadowBorderRadius,
      shape: shape ??
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
      borderRadius: borderRadius ?? BorderRadius.circular(8.r),
      onPressed: onPressed,
      child: Padding(
        padding:
            padding ?? EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 8.0.h),
        child: child,
      ),
    );
  }
}
