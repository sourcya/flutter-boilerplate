part of '../../imports/register_imports.dart';

class BuildRegisterSubtitleWidget extends StatelessWidget {
  const BuildRegisterSubtitleWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.r,
        horizontal: 4.r,
      ),
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
