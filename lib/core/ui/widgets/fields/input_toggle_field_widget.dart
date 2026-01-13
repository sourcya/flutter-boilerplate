part of '../../ui.dart';

class InputFieldToggleWidget extends StatelessWidget {
  final String label;
  final bool isRequired;
  final bool isTranslatable;
  final EdgeInsetsGeometry? padding;
  final bool value;
  final void Function(bool) onChanged;

  const InputFieldToggleWidget({
    required this.label,
    this.isRequired = false,
    this.isTranslatable = true,
    this.padding,
    this.value = false,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onChanged(!value);
      },
      borderRadius: Style.fieldBorderRadius,
      child: Container(
        padding:
            padding ??
            EdgeInsets.symmetric(
              horizontal: 12.r,
              vertical: 12.r,
            ),
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: Style.fieldBorderRadius,
        ),
        margin: EdgeInsets.symmetric(horizontal: 8.r),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0.r),
                child: RichText(
                  text: TextSpan(
                    text: isTranslatable ? label.tr(context: context) : label,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
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
            PlatformSwitch(
              value: value,
              onChanged: onChanged,
              activeColor: context.colors.primary,
            ),
          ],
        ),
      ),
    );
  }
}
