import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/style/style.dart';
import 'package:playx/playx.dart' hide NumDurationExtensions;

import '../../resources/colors/app_colors.dart';
import 'custom_text.dart';

class CustomElevatedButton extends StatelessWidget {
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onPressed;
  final bool isLoading;
  final String? label;
  final double? fontSize;
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
    this.child, this.borderRadius, this.width,
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
      width: width ?? double.infinity ,
      child: PlatformElevatedButton(
        onPressed: onPressed,
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 8.w,
              vertical: 18.h,
            ),
        color: colorScheme.buttonBackgroundColor,
        material: (ctx, _) => MaterialElevatedButtonData(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: disabledBackground ?? colorScheme.disabledButtonBackgroundColor,
            padding: padding ??
                EdgeInsets.symmetric(
                  horizontal: 8.w,
                  vertical: 18.h,
                ),
            shape:
            RoundedRectangleBorder(borderRadius:borderRadius ?? Style.buttonBorderRadius),
            backgroundColor: colorScheme.buttonBackgroundColor,
          ),
        ),
        cupertino: (ctx, _) => CupertinoElevatedButtonData(
          disabledColor: disabledBackground ?? colorScheme.disabledButtonBackgroundColor,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: 8.w,
                vertical: 18.h,
              ),
          color: colorScheme.buttonBackgroundColor,
          borderRadius:borderRadius?? Style.buttonBorderRadius,
        ),
        child: _buildChildWidget(context, isEnabled: onPressed!= null),
      ),
    );
  }

  Widget _buildChildWidget(BuildContext context, {required bool isEnabled }) {
    if (child != null) return child!;

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedOpacity(
          opacity: isLoading ? 0:1,
          duration: 150.milliseconds,
          child: CustomText(
            label ??'',
            color: isEnabled ? colorScheme.onButtonColor :XColors.grey ,
            fontSize: fontSize ,
          ),
        ),
        AnimatedOpacity(
          opacity: isLoading ? 1:0,
          duration: 150.milliseconds,
          child:SizedBox(
            height: 20,
            width: 20,
            child: CenterLoading.adaptive(
              color: isEnabled ? colorScheme.onButtonColor :XColors.grey ,
              radius: isCupertino(context) ? 10: 3,
            ),
          ),
        ),

      ],
    );

  }
}
