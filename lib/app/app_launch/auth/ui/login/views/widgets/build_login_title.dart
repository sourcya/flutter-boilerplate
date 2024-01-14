
part of '../../imports/login_imports.dart';

class BuildLoginTitleWidget extends StatelessWidget {

    const BuildLoginTitleWidget();

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
                AppTrans.loginText.tr,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        // color: colorScheme.onBackground,
                        fontSize: 40.sp,
                    ),
                ),
            ),
        );
    }
}
