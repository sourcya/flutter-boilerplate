
part of '../../imports/login_imports.dart';

class BuildLoginRegisterNowWidget extends GetView<LoginController> {

    const BuildLoginRegisterNowWidget();

    @override
    Widget build(BuildContext context) {
        return Padding(
            padding: EdgeInsets.symmetric(
                vertical: 10.h,
            ),
            child: InkWell(
                onTap: controller.navigateToRegister,
                child: RichText(
                    text: TextSpan(
                        text: AppTrans.dontHaveAccountText.tr,
                        style: TextStyle(
                            color: colorScheme.onBackground,
                            fontSize: 14.sp,
                        ),
                        children: <TextSpan>[
                            TextSpan(
                                text: AppTrans.registerNow.tr,
                                style: TextStyle(
                                    color: colorScheme.secondary,
                                    fontSize: 14.sp,
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
