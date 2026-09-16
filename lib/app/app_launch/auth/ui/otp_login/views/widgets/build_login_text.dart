part of '../../imports/login_view_imports.dart';

class BuildLoginText extends StatelessWidget {
  const BuildLoginText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingOnly(end: 10, start: 10, bottom: 10, top: 10),
      width: double.infinity,
      child: CustomText(
        AppTrans.loginText,
        // color: context.colors.onSurface,
        fontSize: 40.sp,
      ),
    );
  }
}
