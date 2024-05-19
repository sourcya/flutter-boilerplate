part of '../../imports/register_imports.dart';

class BuildRegisterTitleWidget extends StatelessWidget {
  const BuildRegisterTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      width: double.infinity,
      child: CustomText(
        AppTrans.registerText,
        fontSize: 40.sp,
      ),
    );
  }
}
