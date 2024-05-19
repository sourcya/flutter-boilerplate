part of '../../imports/login_view_imports.dart';

class BuildLoginSubtitleText extends StatelessWidget {
  const BuildLoginSubtitleText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10.h,
        right: 10.w,
        left: 10.w,
        bottom: 10.h,
      ),
      width: double.infinity,
      child: CustomText(
        AppTrans.loginSubtitle,
        color: context.colors.subtitleTextColor,
        fontSize: 15.sp,
      ),
    );
  }
}
