part of '../../ui.dart';

class FeatureChip extends StatelessWidget {
  final String? label;
  final IconInfo? icon;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;

  final double? iconSize;
  final BorderSide? borderSide;
  final TextAlign? textAlign;
  final bool isLabelTranslatable;
  final double? fontSize;
  final int maxLines;
  final bool decreaseFontSizeByLength;
  final double defaultVerticalPadding;
  final bool? isMaxWidth;
  final ShapeBorder? shape;

  final double? elevation;

  const FeatureChip({
    this.label,
    this.color = Colors.black,
    this.icon,
    this.backgroundColor,
    this.padding,
    this.contentPadding,
    this.iconSize,
    this.borderSide,
    this.textAlign,
    this.isLabelTranslatable = true,
    this.fontSize,
    this.maxLines = 2,
    this.decreaseFontSizeByLength = false,
    this.defaultVerticalPadding = 16,
    this.isMaxWidth,
    this.margin,
    this.shape,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    final label = isLabelTranslatable
        ? this.label?.tr(context: context)
        : this.label;
    double labelFontSize =
        fontSize ?? (PlayxLocalization.isCurrentLocaleArabic() ? 14.sp : 15.sp);
    final labelLength = label?.length ?? 0;

    if (decreaseFontSizeByLength && labelLength > 10) {
      labelFontSize =
          labelFontSize -
          (labelLength > 35
                  ? 2
                  : labelLength > 20
                  ? 1
                  : 0)
              .sp;
    }

    final labelWidget = CustomText(
      label ?? '',
      isTranslatable: false,
      color: color,
      fontSize: labelFontSize,
      fontWeight: label?.isArabic == true ? FontWeight.w500 : FontWeight.w400,
      font: fontFamilyBasedOnText(
        label,
        isTranslatable: false,
      ),
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines,
      textOverflow: TextOverflow.ellipsis,
    );

    final isMaxWidth = this.isMaxWidth ?? (context.width <= 600);

    return Container(
      margin: margin,
      child: Material(
        color: backgroundColor ?? context.colors.chipBackgroundColor,
        elevation: elevation ?? (context.isDark ? 2 : 0),
        shadowColor: isCupertino(context) ? Colors.black : null,
        shape:
            shape ??
            RoundedRectangleBorder(
              side: borderSide ?? BorderSide(color: context.colors.onSurface),
              borderRadius: BorderRadius.circular(16.r),
            ),
        child: Container(
          padding:
              contentPadding ??
              padding ??
              EdgeInsets.symmetric(
                vertical: (label?.length ?? 10) > 28
                    ? 10.r
                    : defaultVerticalPadding.r,
                horizontal: (label?.length ?? 10) > 5 ? 12.r : 24.r,
              ),
          child: icon != null
              ? Row(
                  mainAxisSize: isMaxWidth
                      ? MainAxisSize.max
                      : MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    icon!.buildIconWidget(
                      size: iconSize ?? icon!.size ?? 20.r,
                      color: color,
                    ),
                    SizedBox(
                      width: 4.r,
                    ),
                    if (isMaxWidth)
                      Expanded(
                        child: labelWidget,
                      )
                    else
                      labelWidget,
                  ],
                )
              : labelWidget,
        ),
      ),
    );
  }
}
