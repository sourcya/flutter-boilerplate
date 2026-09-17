part of '../../imports/register_imports.dart';

class BuildRegisterSubtitleWidget extends StatelessWidget {
  const BuildRegisterSubtitleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingSymmetric(vertical: 12, horizontal: 4),
      width: double.infinity,
      child: CustomText(
        AppTrans.registerSubtitle,
        fontSize: 22.sp,
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
