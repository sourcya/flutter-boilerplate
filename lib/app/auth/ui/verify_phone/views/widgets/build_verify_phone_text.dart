part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyPhoneText extends StatelessWidget {

  const BuildVerifyPhoneText();

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
        AppTrans.verifyPhoneTitle.tr,
        style: TextStyle(
          color: colorScheme.onBackground,
          fontSize: 30.sp,
        ),
      ),
    );
  }

}
