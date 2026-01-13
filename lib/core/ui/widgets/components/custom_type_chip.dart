part of '../../ui.dart';

/// A reusable, customizable chip component designed to display a text label and an optional icon.
///
/// This widget mirrors the layout and style definition of the provided function.
/// It uses standard Flutter units instead of screen utility extensions (.r, .sp)
/// for universal compatibility.
class CustomTypeChip extends StatelessWidget {
  const CustomTypeChip({
    super.key,
    required this.text,
    required this.color,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.isFlat = false,
    this.isCenter = false,
    this.addBorderSide,
    this.padding,
  });
  const CustomTypeChip.flat({
    super.key,
    required this.text,
    required this.color,
    this.icon,
    this.backgroundColor,
    this.borderColor,
    this.isFlat = true,
    this.isCenter = false,
    this.addBorderSide,
    this.padding,
  });

  /// The text content of the chip.
  final String text;

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
  final bool isCenter;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 10.0.r, vertical: 5.0.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0.r),
        border:
            (addBorderSide == true ||
                (addBorderSide == null && borderColor != null))
            ? Border.all(color: borderColor ?? color, width: 0.8.r)
            : null,
        color: backgroundColor,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: isCenter
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        spacing: !isFlat ? 0 : 4.r,
        children: [
          if (text.length <= 2 && !isFlat) 6.boxW,
          // Display icon if provided
          if (icon != null) ...[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                icon!.buildIconWidget(color: color, size: icon?.size ?? 16.0.r),
              ],
            ),
            if (!isFlat) SizedBox(width: 5.0.r),
          ],
          // Text content
          Flexible(
            child: CustomText(
              text,
              color: color,
              fontSize: 12.0.sp,
              fontWeight: FontWeight.w600,
              font: fontFamilyBasedOnText(text),
              textAlign: TextAlign.center,
              textOverflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
          if (text.length <= 2 && !isFlat) 6.boxW,
        ],
      ),
    );
    return isCenter ? Center(child: child) : child;
  }
}
