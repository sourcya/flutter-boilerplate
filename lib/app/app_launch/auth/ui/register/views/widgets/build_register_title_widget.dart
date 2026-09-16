part of '../../imports/register_imports.dart';

class BuildRegisterTitleWidget extends StatelessWidget {
  const BuildRegisterTitleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(vertical: 4, horizontal: 4),
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
