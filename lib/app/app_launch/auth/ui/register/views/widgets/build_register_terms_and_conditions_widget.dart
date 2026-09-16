part of '../../imports/register_imports.dart';

class BuildRegisterTermsAndConditionsWidget extends StatelessWidget {
  const BuildRegisterTermsAndConditionsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingSymmetric(vertical: 4, horizontal: 10),
      child: RichText(
        maxLines: 2,
        text: TextSpan(
          text: AppTrans.termsAndPrivacyInitialText.tr(context: context),
          style: TextStyle(
            color: context.colors.subtitleTextColor,
            fontSize: 12.sp,
            fontFamily: fontFamily(context: context),
          ),
          children: <TextSpan>[
            TextSpan(
              text: AppTrans.terms.tr(context: context),
              style: TextStyle(
                color: context.colors.subtitleTextColor,
                fontSize: 12.sp,
                fontFamily: fontFamily(context: context),
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
              text: AppTrans.andText.tr(context: context),
              style: TextStyle(
                color: context.colors.subtitleTextColor,
                fontSize: 12.sp,
                fontFamily: fontFamily(context: context),
              ),
            ),
            TextSpan(
              text: AppTrans.privacyPolicyText.tr(context: context),
              style: TextStyle(
                color: context.colors.subtitleTextColor,
                fontSize: 12.sp,
                fontFamily: fontFamily(context: context),
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    );
  }
}
