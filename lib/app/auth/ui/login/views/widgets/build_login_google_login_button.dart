
part of '../../imports/login_imports.dart';

class BuildLoginGoogleLoginButtonWidget extends GetView<LoginController> {

    const BuildLoginGoogleLoginButtonWidget();

    @override
    Widget build(BuildContext context) {
        return SizedBox(
            width: context.width * 0.55,
            height: context.height * 0.06,
            child: buildGoogleSignInButton(
                onPressed: controller.loginWithGoogle,
                isDark: AppUtils.isDarkMode(),
            ),
        );
    }
}
