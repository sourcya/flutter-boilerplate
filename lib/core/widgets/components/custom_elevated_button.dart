import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_colors.dart';
import '../../resources/style/style.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? label;
  final String? labelFont;

  final double? fontSize;
  final Color? color;

  final Color? disabledBackground;
  final Widget? child;
  final BorderRadius? borderRadius;

  final double? width;

  const CustomElevatedButton({
    this.margin,
    this.onPressed,
    this.isLoading = false,
    this.padding,
    this.fontSize,
    this.label,
    this.disabledBackground,
    this.child,
    this.borderRadius,
    this.width = double.infinity,
    this.labelFont,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ??
          EdgeInsets.only(
            right: 14.w,
            left: 14.w,
            top: 11.h,
            bottom: 11.h,
          ),
      width: width,
      child: PlatformElevatedButton(
        onPressed: onPressed != null
            ? () {
                if (isLoading) return;
                onPressed!();
              }
            : null,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 16.h,
            ),
        material: (ctx, _) => MaterialElevatedButtonData(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor:
                disabledBackground ?? colorScheme.disabledButtonBackgroundColor,
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 18.h,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius ?? Style.buttonBorderRadius,
            ),
            backgroundColor: color ?? colorScheme.primary,
          ),
        ),
        color: color ?? colorScheme.primary,
        cupertino: (ctx, _) => CupertinoElevatedButtonData(
          disabledColor:
              disabledBackground ?? colorScheme.disabledButtonBackgroundColor,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 18.h,
              ),
          borderRadius: borderRadius ?? Style.buttonBorderRadius,
        ),
        child: _buildChildWidget(
          context,
          isEnabled: onPressed != null,
          labelFont: labelFont,
        ),
      ),
    );
  }

  Widget _buildChildWidget(
    BuildContext context, {
    required bool isEnabled,
    String? labelFont,
  }) {
    if (child != null) return child!;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0 : 1,
          duration: 150.milliseconds,
          child: CustomText(
            label ?? '',
            color: isEnabled
                ? colorScheme.onPrimary
                : colorScheme.subtitleTextColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
            font: labelFont,
          ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1 : 0,
          duration: 150.milliseconds,
          child: SizedBox(
            height: 20.r,
            width: 20.r,
            child: CenterLoading.adaptive(
              color: isEnabled
                  ? colorScheme.onPrimary
                  : colorScheme.subtitleTextColor,
              radius: 10.r,
              strokeWidth: 3.r,
            ),
          ),
        ),
      ],
    );
  }
}
