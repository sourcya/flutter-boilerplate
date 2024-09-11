part of '../../imports/register_imports.dart';

class BuildRegisterTermsAndConditionsWidget extends StatelessWidget {
  const BuildRegisterTermsAndConditionsWidget();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 15.h,
        horizontal: 10.w,
      ),
      child: RichText(
        text: TextSpan(
          text: AppTrans.termsAndPrivacyInitialText.tr(context: context),
          style: TextStyle(
            // color: context.colors.onSurface,
            fontSize: 12.sp,
          ),
          children: <TextSpan>[
            TextSpan(
              text: AppTrans.terms.tr(context: context),
              style: TextStyle(
                // color: context.colors.secondary,
                fontSize: 12.sp,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
            TextSpan(
              text: AppTrans.andText.tr(context: context),
              style: TextStyle(
                // color: context.colors.onSurface,
                fontSize: 12.sp,
              ),
            ),
            TextSpan(
              text: AppTrans.privacyPolicyText.tr(context: context),
              style: TextStyle(
                // color: context.colors.secondary,
                fontSize: 12.sp,
              ),
              recognizer: TapGestureRecognizer()..onTap = () {},
            ),
          ],
        ),
      ),
    );
  }
}
