part of '../../imports/splash_imports.dart';

class BuildSplashAppVersionWidget extends StatelessWidget {
  const BuildSplashAppVersionWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 30.r,
        horizontal: 10.r,
      ),
      alignment: Alignment.center,
      child: AppVersion(
        textStyle: TextStyle(
          fontSize: 13.sp,
          color: context.colors.primary,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
