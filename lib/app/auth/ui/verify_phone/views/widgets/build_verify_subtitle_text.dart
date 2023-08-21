part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifySubtitleText extends StatelessWidget {

  const BuildVerifySubtitleText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 10.w,
        left: 10.w,
        bottom: 10.h,
      ),
      width: double.infinity,
      child: Text(
        AppTrans.verifyPhoneSubtitle.tr,
        style: TextStyle(
          color: colorScheme.subtitleTextColor,
          fontSize: 15.sp,
        ),
      ),
    );
  }

}
