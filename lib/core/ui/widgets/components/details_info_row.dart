part of '../../ui.dart';

class DetailsInfoRow extends StatelessWidget {
  final Color? iconBgColor;
  final IconInfo icon;
  final Color? iconColor;
  final Color? contentColor;
  final String label;
  final String? txt;
  final String? suffixTxt;
  final Widget? child;
  final bool dividerAbove;
  final FontWeight? contentWeight;
  final bool dividerBelow;
  final EdgeInsetsGeometry? contentPadding;
  final bool cardIconOnStart;
  final bool hoverBorderIsOn;

  const DetailsInfoRow({
    super.key,
    this.iconBgColor,
    this.contentColor,
    required this.icon,
    this.iconColor,
    required this.label,
    this.child,
    this.dividerAbove = false,
    this.cardIconOnStart = false,
    this.hoverBorderIsOn = true,
    this.dividerBelow = false,
    this.contentPadding,
    this.txt,
    this.contentWeight,
    this.suffixTxt,
  });

  @override
  Widget build(BuildContext context) {
    final iconWidget = DetailsInfoRowIcon(
      icon: icon,
      iconBgColor: iconBgColor,
      iconColor: iconColor,
    );
    final valueText = CustomText(
      txt ?? '',
      color: contentColor ?? context.colors.foreground,
      fontSize: 16.sp,
      fontWeight: contentWeight ?? FontWeight.w600,
      height: 1.75,
      font: fontFamilyBasedOnText(txt),
    );

    return Container(
      width: double.infinity,
      padding: hoverBorderIsOn ? context.paddingAll(12.0) : null,
      margin: context.paddingOnly(bottom: 8.0),
      clipBehavior: hoverBorderIsOn ? Clip.antiAlias : Clip.none,
      decoration: hoverBorderIsOn
          ? ShapeDecoration(
              color: context.colors.screenCardSurface,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 1.r,
                  color: context.colors.cardBorderColor,
                ),
                borderRadius: 12.radius,
              ),
            )
          : null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (dividerAbove)
            Divider(
              height: 1,
              thickness: 1,
              color: context.colors.cardBorderColor,
            ),
          // Label row — icon shares the trailing edge of the card.
          Row(
            spacing: 8.r,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (cardIconOnStart) iconWidget,
              Expanded(
                child: CustomText(
                  label,
                  color: context.colors.mutedForeground,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.71,
                ),
              ),
              if (!cardIconOnStart) iconWidget,
            ],
          ),
          // Value spans full card width so trailing content
          // (e.g. absolute date) aligns with the icon's end.
          child ??
              (suffixTxt == null
                  ? valueText
                  : Row(
                      children: [
                        Expanded(child: valueText),
                        CustomText(
                          suffixTxt!,
                          color: context.colors.foreground,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.67,
                          isTranslatable: false,
                        ),
                      ],
                    )),
          if (dividerBelow)
            Divider(
              height: 1,
              thickness: 1,
              color: context.colors.cardBorderColor,
            ),
        ],
      ),
    );
  }
}
