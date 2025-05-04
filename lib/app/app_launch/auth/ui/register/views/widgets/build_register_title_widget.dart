part of '../../imports/register_imports.dart';

class BuildRegisterTitleWidget extends StatelessWidget {
  const BuildRegisterTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 4.r,
        horizontal: 4.r,
      ),
      width: double.infinity,
      child: CustomText(
        AppTrans.registerTitle,
        fontSize: 24.sp,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}
