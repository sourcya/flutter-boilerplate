part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifyPhoneText extends StatelessWidget {
  const BuildVerifyPhoneText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingOnly(end: 10, start: 10, bottom: 10),
      width: double.infinity,
      child: CustomText(
        AppTrans.verifyPhoneTitle,
        fontSize: 30.sp,
      ),
    );
  }
}
