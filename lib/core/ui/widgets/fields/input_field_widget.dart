part of '../../ui.dart';

class InputFieldWidget extends StatelessWidget {
  final String label;
  final String? subtitle;
  final String? tooltip;
  final double? labelFontSize;
  final FontWeight? labelFontWeight;
  final Widget child;
  final bool isRequired;
  final bool isTranslatable;
  final EdgeInsetsGeometry? padding;
  final bool showBorder;
  final Widget? trailing;

  const InputFieldWidget({
    required this.label,
    this.subtitle,
    required this.child,
    this.labelFontSize,
    this.labelFontWeight,
    this.tooltip,
    this.isRequired = false,
    this.isTranslatable = true,
    this.padding,
    this.showBorder = true,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.0.r),
                  child: RichText(
                    text: TextSpan(
                      text: isTranslatable ? label.tr(context: context) : label,
                      style: TextStyle(
                        fontWeight: labelFontWeight ?? FontWeight.w700,
                        fontSize: labelFontSize ?? 16.sp,
                        color: context.colors.onSurface,
                        fontFamily: fontFamily(context: context),
                      ),
                      children: [
                        if (isRequired)
                          TextSpan(
                            text: ' *',
                            style: TextStyle(
                              color: context.colors.subtitleTextColor,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (trailing != null) trailing!,
              if (tooltip != null && tooltip!.isNotEmpty)
                Tooltip(
                  message: tooltip?.tr(context: context),
                  padding: EdgeInsets.symmetric(horizontal: 8.r, vertical: 8.r),
                  margin: EdgeInsets.symmetric(horizontal: 8.r),
                  triggerMode: TooltipTriggerMode.tap,
                  child: Icon(
                    Icons.info_outline,
                    color: context.colors.onSurface.withValues(alpha: .7),
                  ),
                ),
            ],
          ),
          if (subtitle != null && subtitle!.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0.r, vertical: 4.0.r),
              child: CustomText(
                isTranslatable ? subtitle!.tr(context: context) : subtitle!,
                fontSize: 13.sp,
                color: context.colors.subtitleTextColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          child,
        ],
      ),
    );
  }
}
