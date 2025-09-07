part of '../../imports/register_imports.dart';

class BuildRegisterTermsAndConditionsWidget extends StatelessWidget {
  const BuildRegisterTermsAndConditionsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.r,
        horizontal: 10.r,
      ),
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  PlayxNavigation.toNamed(Routes.termsConditions);
                },
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
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  PlayxNavigation.toNamed(Routes.privacyPolicy);
                },
            ),
          ],
        ),
      ),
    );
  }
}
