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
  final IconInfo? icon;
  final Color? iconColor;
  final double? iconSize;
  final bool isTranslatable;
  final TextDecoration? decoration;
  final double? letterSpacing;
  final double? height;
  final bool isSelectable;
  final int? readMoreTextLength;
  final List<Shadow>? shadows;
  final Color? strokeColor;
  final double? strokeWidth;

  final bool? softWrap;
  final double? iconSpacing;
  final BuildContext? translationContext;

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
    this.translationContext,
    this.softWrap,
  })  : icon = null,
        iconColor = null,
        iconSpacing = null,
        iconSize = null,
        strokeColor = null,
        strokeWidth = null;

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
    this.strokeColor,
    this.strokeWidth,
    this.translationContext,
    this.softWrap,
    this.iconSpacing,
  });

  const CustomText.stroke(
    this.text, {
    required Color this.strokeColor,
    double this.strokeWidth = 3,
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
    this.translationContext,
    this.softWrap,
  })  : icon = null,
        iconColor = null,
        iconSpacing = null,
        iconSize = null;

  @override
  Widget build(BuildContext context) {
    final translatedText =
        isTranslatable ? text.tr(context: translationContext ?? context) : text;

    final effectiveTextStyle = textStyle?.copyWith(
          color: color,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: textOverflow,
          fontFamily: font,
          decoration: decoration ?? TextDecoration.none,
          letterSpacing: letterSpacing,
          height: height,
          shadows: shadows,
        ) ??
        TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          fontFamily: fontFamily(context: context),
        ).copyWith(
          color: color ?? context.colors.onSurface,
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontStyle: fontStyle,
          overflow: textOverflow,
          fontFamily: font,
          decoration: decoration ?? TextDecoration.none,
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
            : strokeColor != null
                ? StrokeText(
                    text: translatedText,
                    strokeColor: strokeColor ?? Colors.black,
                    strokeWidth: strokeWidth ?? 3,
                    textStyle: effectiveTextStyle,
                    maxLines: maxLines,
                    textAlign: textAlign,
                    overflow: textOverflow,
                  )
                : Text(
                    translatedText,
                    style: effectiveTextStyle,
                    maxLines: maxLines,
                    textAlign: textAlign,
                    overflow: textOverflow,
                    softWrap: softWrap,
                  );

    if (icon == null) {
      return textWidget;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          icon!
              .copyWith(
                color: iconColor ?? color ?? context.colors.onSurface,
                size: iconSize ?? 20.r,
              )
              .buildIconWidget(),
          SizedBox(width: iconSpacing ?? 4.0.r),
        ],
        Flexible(child: textWidget),
      ],
    );
  }
}
/// Predefined text styles for commonly used text categories.
class CustomTextStyles {
  const CustomTextStyles._();

  static TextStyle headline(BuildContext context) => TextStyle(
    fontSize: 32.sp,
    fontWeight: FontWeight.bold,
    fontFamily: fontFamily(context: context),
    color: context.colors.onSurface,
  );

  static TextStyle title(BuildContext context) => TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily(context: context),
    color: context.colors.onSurface,
  );

  static TextStyle subtitle(BuildContext context) => TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    fontFamily: fontFamily(context: context),
    color: context.colors.onSurface,
  );

  static TextStyle body(BuildContext context) => TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily(context: context),
    color: context.colors.onSurface,
  );

  static TextStyle label(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: context),
    color: context.colors.onSurface,
  );

  static TextStyle caption(BuildContext context) => TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    fontFamily: fontFamily(context: context),
    color: context.colors.onSurface,
  );

  static TextStyle description(BuildContext context) => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    fontFamily: fontFamily(context: context),
    color: context.colors.subtitleTextColor,
  );
}
