part of '../../imports/verify_phone_view_imports.dart';

class BuildVerifySubtitleText extends StatelessWidget {
  const BuildVerifySubtitleText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: context.paddingOnly(end: 10, start: 10, bottom: 10),
      width: double.infinity,
      child: CustomText(
        AppTrans.verifyPhoneSubtitle,
        color: context.colors.subtitleTextColor,
        fontSize: 15.sp,
      ),
    );
  }
}
