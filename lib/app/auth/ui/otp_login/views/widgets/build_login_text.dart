part of '../../imports/login_view_imports.dart';

class BuildLoginText extends StatelessWidget {

  const BuildLoginText();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        right: 10.w,
        left: 10.w,
        bottom: 10.h,
        top: 10.h,
      ),
      width: double.infinity,
      child: Text(
        AppTrans.loginText.tr,
        style:TextStyle(
          color: colorScheme.onBackground,
          fontSize: 40.sp,
        ),
      ),
    );
  }

}
