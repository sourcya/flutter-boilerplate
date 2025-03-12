part of '../../ui.dart';

/// A custom text widget that allows for easy customization of text styles.
/// It supports icons, translation, and predefined style presets.
class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextOverflow textOverflow;
  final int? maxLines;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final String? font;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final bool isTranslatable;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;
  final bool isSelectable;
  final int? readMoreTextLength;
  final List<Shadow>? shadows;

  const CustomText(
    this.text, {
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.font,
    this.isTranslatable = true,
    this.decoration,
    this.letterSpacing,
    this.height,
    this.isSelectable = false,
    this.readMoreTextLength,
    this.shadows,
  })  : icon = null,
        iconColor = null,
        iconSize = null;

  const CustomText.icon(
    this.text, {
    required this.icon,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.fontStyle,
    this.textOverflow = TextOverflow.visible,
    this.maxLines,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.font,
    this.iconColor,
    this.iconSize,
    this.isTranslatable = true,
    this.decoration,
    this.letterSpacing,
    this.height,
    this.isSelectable = false,
    this.readMoreTextLength,
    this.shadows,
  });

  @override
  Widget build(BuildContext context) {
    final translatedText = isTranslatable ? text.tr(context: context) : text;

    final effectiveTextStyle = textStyle?.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: textOverflow,
          fontFamily: font,
          decoration: decoration,
          letterSpacing: letterSpacing,
          height: height,
          shadows: shadows,
        ) ??
        CustomTextStyles.label.copyWith(
          color: color ?? context.colors.onSurface,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: textOverflow,
          fontFamily: font,
          decoration: decoration,
          letterSpacing: letterSpacing,
          height: height,
          shadows: shadows,
        );

    final textWidget = (readMoreTextLength ?? 0) > 0
        ? ReadMoreText(
            translatedText,
            style: effectiveTextStyle,
            readMoreExpandedText: AppTrans.readMore,
            readMoreCollapsedText: AppTrans.readLess,
            readMoreTextStyle: effectiveTextStyle.copyWith(
              color: context.colors.primary,
              fontWeight: FontWeight.bold,
            ),
          )
        : isSelectable
            ? SelectableText(
                translatedText,
                style: effectiveTextStyle,
                maxLines: maxLines,
                textAlign: textAlign,
              )
            : Text(
                translatedText,
                style: effectiveTextStyle,
                maxLines: maxLines,
                textAlign: textAlign,
                overflow: textOverflow,
              );

    if (icon == null) {
      return textWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: iconColor ?? color ?? context.colors.onSurface,
          size: iconSize ?? 20.r,
        ),
        SizedBox(width: 4.0.r),
        Flexible(
          child: textWidget,
        ),
      ],
    );
  }
}

/// Predefined text styles for commonly used text categories.
class CustomTextStyles {
  const CustomTextStyles._();

  static TextStyle headline = TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily,
  );

  static TextStyle title = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
  );

  static TextStyle subtitle = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily,
  );

  static TextStyle body = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
  );

  static TextStyle label = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily,
  );

  static TextStyle description(BuildContext context) => TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        fontFamily: fontFamily,
        color: context.colors.subtitleTextColor,
      );

  static List<Shadow> outlinedText(
      {double strokeWidth = 1,
      Color strokeColor = Colors.black,
      int precision = 5}) {
    final Set<Shadow> result = HashSet();
    for (int x = 1; x < strokeWidth + precision; x++) {
      for (int y = 1; y < strokeWidth + precision; y++) {
        final double offsetX = x.toDouble();
        final double offsetY = y.toDouble();
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(-strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, -strokeWidth / offsetY),
            color: strokeColor));
        result.add(Shadow(
            offset: Offset(strokeWidth / offsetX, strokeWidth / offsetY),
            color: strokeColor));
      }
    }
    return result.toList();
  }
}
