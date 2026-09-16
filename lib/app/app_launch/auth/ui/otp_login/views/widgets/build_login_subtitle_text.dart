part of '../../imports/login_view_imports.dart';

class BuildLoginSubtitleText extends StatelessWidget {
  const BuildLoginSubtitleText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingOnly(top: 10, end: 10, start: 10, bottom: 10),
      width: double.infinity,
      child: CustomText(
        AppTrans.loginSubtitle,
        color: context.colors.subtitleTextColor,
        fontSize: 15.sp,
      ),
    );
  }
}
