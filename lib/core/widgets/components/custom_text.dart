import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/colors/app_color_scheme.dart';

enum CustomTextSize {
  body,
  title,
  small,
  medium,
  large;

  double get fontSize => switch (this) {
        body => 16.sp,
        title => 20.sp,
        small => 14.sp,
        medium => 18.sp,
        large => 24.sp,
      };
}

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextOverflow textOverflow;
  final int? maxLines;
  final TextAlign textAlign;
  final CustomTextSize customTextSize;

  const CustomText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.customTextSize = CustomTextSize.body,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color?? colorScheme.onBackground,
        fontSize: fontSize ?? customTextSize.fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        overflow: textOverflow,
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
