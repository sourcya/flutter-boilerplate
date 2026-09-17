part of '../../ui.dart';

class DetailsInfoCard extends StatelessWidget {
  final EdgeInsetsDirectional? padding;
  final EdgeInsetsGeometry? margin;
  final String? title;
  final bool dividerAbove;
  final bool dividerBelow;
  final Widget child;
  final double? fontSize;
  final double? vSpaceTxtAndChild;
  final FontWeight? fontWeight;
  final Color? txtColor;
  final bool isLandscape;
  final bool showBackground;
  final bool titleIsTranslatable;
  const DetailsInfoCard({
    super.key,
    required this.child,
    this.isLandscape = false,
    this.dividerBelow = false,
    this.showBackground = false,
    this.dividerAbove = false,
    this.padding,
    this.margin,
    this.title,
    this.fontSize,
    this.fontWeight,
    this.txtColor,
    this.vSpaceTxtAndChild,
    this.titleIsTranslatable = true,
  });
  // with background
  const DetailsInfoCard.withBackground({
    super.key,
    required this.child,
    this.isLandscape = false,
    this.dividerBelow = false,
    this.dividerAbove = false,
    this.padding,
    this.margin,
    this.title,
    this.fontSize,
    this.fontWeight = FontWeight.w400,
    this.txtColor,
    this.vSpaceTxtAndChild,
    this.titleIsTranslatable = true,
  }) : showBackground = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dividerAbove)
            Divider(height: 1.r, thickness: 1, color: context.colors.cardBorderColor),
          if (title != null)
            CustomText(
              title!,
              isTranslatable: titleIsTranslatable,
              color: txtColor ?? context.colors.onSurface,
              fontSize: fontSize ?? 16.sp,
              fontWeight: fontWeight ?? FontWeight.normal,
              height: 1.43,
            ).marginOnly(bottom: (vSpaceTxtAndChild ?? 16).r),
          Container(
            padding: !showBackground ? null : padding ?? context.paddingAll(16),
            decoration: !showBackground
                ? null
                : BoxDecoration(
                    color: context.colors.screenCardSurface,
                    borderRadius: 16.radius,
                    border: Border.all(color: context.colors.cardBorderColor),
                  ),
            child: child,
          ),
          if (dividerBelow)
            Divider(height: 1.r, thickness: 1, color: context.colors.cardBorderColor),
        ],
      ),
    );
  }
}
