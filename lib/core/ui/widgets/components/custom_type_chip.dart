part of '../../ui.dart';

/// A reusable, customizable chip component designed to display a text label and an optional icon.
///
/// This widget mirrors the layout and style definition of the provided function.
/// It uses standard Flutter units instead of screen utility extensions (.r, .sp)
/// for universal compatibility.
class CustomTypeChip extends StatelessWidget {
  const CustomTypeChip({
    super.key,
    this.text,
    required this.color,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.isFlat = false,
    this.txtISelectable = false,
    this.isCenter = false,
    this.addBorderSide,
    this.padding,
    this.txtSize,
    this.iconSize,
    this.borderRadius,
    this.height,
    this.width,
    this.widget,
    this.onTap,
    this.margin,
  }) : isPill = false;
  const CustomTypeChip.flat({
    super.key,
    this.text,
    this.margin,
    required this.color,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.isFlat = true,
    this.isCenter = false,
    this.txtISelectable = false,
    this.addBorderSide,
    this.padding,
    this.iconSize,
    this.txtSize,
    this.borderRadius,
    this.height,
    this.width,
    this.widget,
    this.onTap,
  }) : isPill = false;

  /// Compact pill chip for list/details metadata (language, format, status, etc.).
  const CustomTypeChip.pill({
    super.key,
    required this.text,
    required this.color,
    this.backgroundColor,
    this.borderColor,
    this.margin,
    this.onTap,
  }) : icon = null,
       isFlat = true,
       isPill = true,
       txtISelectable = false,
       isCenter = false,
       addBorderSide = null,
       padding = null,
       txtSize = null,
       iconSize = null,
       borderRadius = null,
       height = null,
       width = null,
       widget = null;

  /// The text content of the c
  /// hip.
  final String? text;
  final double? txtSize;
  final bool txtISelectable;

  /// The color used for the text, icon, and border.
  final Color color;

  /// The optional icon data to display (e.g., Icons.info).
  final IconInfo? icon;

  /// The optional background color of the chip.
  final Color? backgroundColor;

  final EdgeInsetsGeometry? padding;

  /// The optional border color of the chip.
  final Color? borderColor;

  final bool? addBorderSide;
  final bool isFlat;
  final bool isPill;
  final bool isCenter;
  final double? iconSize;
  final BorderRadiusGeometry? borderRadius;
  final double? height;
  final double? width;
  final Widget? widget;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final shouldSelectText =
        txtISelectable || (onTap == null && WebTableSelectionScope.maybeOf(context));
    final bool isIconOnly = text == null && icon != null && widget == null;
    final child = Container(
      height: height,
      width: width,
      margin: margin,
      alignment: isIconOnly ? Alignment.center : null,
      padding:
          padding ??
          (isPill
              ? context.paddingSymmetric(horizontal: 10, vertical: 4)
              : context.paddingSymmetric(horizontal: 10.0, vertical: 5.0)),
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? (isPill ? 9999.radius : BorderRadius.circular(16.0.r)),
        border: (addBorderSide == true || (addBorderSide == null && borderColor != null))
            ? Border.all(color: borderColor ?? color, width: 0.8.r)
            : null,
        color: backgroundColor,
      ),
      child:
          widget ??
          (text != null || icon != null
              ? text != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isCenter
                            ? MainAxisAlignment.center
                            : MainAxisAlignment.start,
                        spacing: !isFlat ? 0 : 4.r,
                        children: [
                          if (text!.length <= 2 && !isFlat) 6.boxW,
                          // Display icon if provided
                          if (icon != null) ...[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                icon!.buildIconWidget(
                                  color: color,
                                  size: iconSize ?? icon?.size ?? 16.0.r,
                                ),
                              ],
                            ),
                            if (!isFlat) 5.0.wBox,
                          ],
                          // Text content
                          Flexible(
                            child: shouldSelectText
                                ? WebSelectableRichText(
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      text: text?.tr(context: context),
                                      style: TextStyle(
                                        color: color,
                                        fontSize: txtSize ?? (isPill ? 12.sp : 12.0.sp),
                                        fontWeight: FontWeight.w600,
                                        fontFamily: fontFamilyBasedOnText(text),
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  )
                                : CustomText(
                                    text ?? '',
                                    color: color,
                                    fontSize: txtSize ?? (isPill ? 12.sp : 12.0.sp),
                                    fontWeight: FontWeight.w600,
                                    font: fontFamilyBasedOnText(text),
                                    textAlign: TextAlign.center,
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                          ),
                          if (text!.length <= 2 && !isFlat) 6.boxW,
                        ],
                      )
                    : icon!.buildIconWidget(
                        color: color,
                        size: iconSize ?? icon?.size ?? 16.0.r,
                      )
              : const SizedBox()),
    );
    final result = isCenter ? Center(child: child) : child;
    if (onTap != null) {
      return GestureDetector(onTap: onTap, child: result);
    }
    return result;
  }
}
