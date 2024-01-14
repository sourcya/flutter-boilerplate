import 'package:flutter/widgets.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_locale_config.dart';
import 'package:playx/playx.dart';


class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextOverflow textOverflow;
  final int? maxLines;
  final TextAlign textAlign;
  final CustomTextStyle style;
  final TextStyle? textStyle;

  const CustomText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.style = CustomTextStyle.bodyLarge, this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PlatformText(
      text,
      style:textStyle?? TextStyle(
        color: color?? colorScheme.onBackground,
        fontSize: fontSize ?? style.fontSize,
        fontWeight: fontWeight ?? style.fontWeight,
        fontStyle: fontStyle,
        overflow: textOverflow,
        fontFamily: fontFamily
      ),
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}



enum CustomTextStyle {
  displayLarge,
  displayMedium,
  displaySmall,

  headlineLarge,
  headlineMedium,
  headlineSmall,

  titleLarge,
  titleMedium,
  titleSmall,


  bodyLarge,
  bodyMedium,
  bodySmall,

  labelLarge,
  labelMedium,
  labelSmall;


  double get fontSize => switch (this) {
    displayLarge => 57.sp,
    displayMedium => 45.sp,
    displaySmall => 36.sp,

    headlineLarge => 32.sp,
    headlineMedium => 28.sp,
    headlineSmall => 24.sp,


    titleLarge => 28.sp,
    titleMedium => 24.sp,
    titleSmall => 20.sp,

    bodyLarge => 16.sp,
    bodyMedium => 14.sp,
    bodySmall => 12.sp,

    labelLarge => 14.sp,
    labelMedium => 12.sp,
    labelSmall => 11.sp,


  };

  FontWeight get fontWeight => switch (this) {
    displayLarge => FontWeight.w400,
    displayMedium => FontWeight.w400,
    displaySmall => FontWeight.w400,

    headlineLarge => FontWeight.w400,
    headlineMedium => FontWeight.w400,
    headlineSmall => FontWeight.w400,

    titleLarge => FontWeight.w400,
    titleMedium => FontWeight.w500,
    titleSmall => FontWeight.w500,


    bodyLarge => FontWeight.w400,
    bodyMedium => FontWeight.w400,
    bodySmall => FontWeight.w400,


    labelLarge => FontWeight.w500,
    labelMedium => FontWeight.w500,
    labelSmall => FontWeight.w500,


  };

}
