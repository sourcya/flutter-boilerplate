part of '../../imports/register_imports.dart';

class BuildRegisterFieldWidget extends GetView<RegisterController> {
  final String label;
  final Widget textField;

  const BuildRegisterFieldWidget({
    required this.label,
    required this.textField,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.r,
        vertical: 4.r,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.0.r),
            child: CustomText(
              label,
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
            ),
          ),
          textField,
        ],
      ),
    );
  }
}
