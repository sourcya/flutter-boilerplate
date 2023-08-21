import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_color_scheme.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;
  final double? fontSize;
  final Color? disabledBackground;

  const CustomElevatedButton({
    this.margin,
    this.onPressed,
    this.isLoading = false,
    this.padding,
    this.fontSize,
    required this.label, this.disabledBackground,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: margin ??
          EdgeInsets.only(
            right: 14.w,
            left: 14.w,
            top: 12.h,
            bottom: 12.h,
          ),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 18.h,
              ),
          backgroundColor: colorScheme.buttonBackgroundColor,
          disabledBackgroundColor: disabledBackground,
        ),
        child: isLoading
            ? CenterLoading(
                color: colorScheme.onButtonColor,
              )
            : CustomText(
                label,
                color: colorScheme.onButtonColor,
                fontSize: fontSize ,
              ),
      ),
    );
  }
}
