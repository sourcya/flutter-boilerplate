part of '../../../imports/settings_imports.dart';

/// Figma read-only field: white fill, 1px input border, 12px radius, 12×10 padding.
class WebSettingsReadOnlyFieldWidget extends StatelessWidget {
  const WebSettingsReadOnlyFieldWidget({
    super.key,
    required this.value,
    this.readOnly = true,
  });

  final String value;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      readOnly: readOnly,
      child: Container(
        width: context.width,
        padding: context.paddingSymmetric(horizontal: 12, vertical: 10),
        decoration: ShapeDecoration(
          color: context.colors.inputBackgroundColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: context.colors.inputBorderColor),
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        alignment: AlignmentDirectional.centerStart,
        child: CustomText(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textStyle: context.bodyMediumTS.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.43,
            color: context.colors.cardForeground,
          ),
        ),
      ),
    );
  }
}
