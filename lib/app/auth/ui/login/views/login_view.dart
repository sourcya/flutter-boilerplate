import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/auth/ui/login/views/widgets/google_sign_in_button/sign_in_button/stub.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/assets.dart';
import '../../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/utils/app_utils.dart';
import '../../../../../core/widgets/text_field.dart';
import '../controllers/login_controller.dart';

// login screen widget.
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OptimizedScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 5,
              horizontal: 5,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLottieAnimation(context),
                _buildLoginText(context),
                _buildEmailTextFormField(context),
                _buildPasswordTextFormField(context),
                _buildLoginButton(context),
                _buildGoogleLoginButton(context),
                _buildRegisterNowWidget(context),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLottieAnimation(BuildContext context) {
    return Lottie.asset(
      AppAssets.loginAnimation,
      width: double.infinity,
      height: context.height * .4,
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return Container(
      padding:  EdgeInsets.only(
        right: 10.w,
        left: 10.w,
        bottom: 10.h,
      ),
      width: double.infinity,
      child: Text(
        AppTrans.loginText.tr,
        style: GoogleFonts.poppins(
          textStyle: TextStyle(
            color: colorScheme.onBackground,
            fontSize: 40.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextFormField(
    BuildContext context,
  ) {
    return Padding(
      padding:  EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 5.h,
      ),
      child: CustomTextField(
        label: AppTrans.emailOrUsernameLabel.tr,
        hint: AppTrans.emailHint.tr,
        controller: controller.emailController,
        type: TextInputType.emailAddress,
        validator: qValidator([
          IsRequired(AppTrans.emailRequired.tr),
        ]),
        prefix: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
          child: Icon(
            Icons.email,
            color: colorScheme.secondary,
            size: 20.r,
          ),
        ),
        shouldAutoValidate: true,
        onValidationChanged: (isValid) {
          controller.isEmailValid.value = isValid;
        },
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _buildPasswordTextFormField(
    BuildContext context,
  ) {
    return Obx(() {
      return Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        child: CustomTextField(
          label: AppTrans.passwordLabel.tr,
          hint: AppTrans.passwordHint.tr,
          controller: controller.passwordController,
          obscureText: controller.hidePassword.value,
          type: TextInputType.visiblePassword,
          suffix: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
            child: IconButton(
              icon: Icon(
                controller.hidePassword.value
                    ? Icons.visibility_off
                    : Icons.visibility,
                size: 20.r,
              ),
              onPressed: () {
                controller.hidePassword.value = !controller.hidePassword.value;
              },
              color: colorScheme.secondary,
            ),
          ),
          validator: qValidator([
            IsRequired(
              AppTrans.passwordRequired.tr,
            ),
            MinLength(6, AppTrans.passwordMinLengthError.tr)
          ]),
          prefix: Padding(
            padding:  EdgeInsets.symmetric(horizontal: 8.0.w),
            child: Icon(
              Icons.lock,
              color: colorScheme.secondary,
              size: 20.r,
            ),
          ),
          shouldAutoValidate: true,
          onValidationChanged: (isValid) {
            controller.isPasswordValid.value = isValid;
          },
        ),
      );
    });
  }

  Widget _buildLoginButton(BuildContext context) {
    return Obx(() {
      return Container(
        padding:  EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 5.h,
        ),
        margin:  EdgeInsets.symmetric(
          vertical: 10.h,
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            padding:  const EdgeInsets.all(8),
          ),
          onPressed: controller.login,
          child: SizedBox(
            width: context.width * 0.5,
            height: context.height * 0.05,
            child: controller.isLoading.value
                ? CenterLoading(
                    color: colorScheme.onSecondary,
                  )
                : Center(
                    child: Text(
                      AppTrans.loginText.tr,
                      style: TextStyle(
                        color: colorScheme.onSecondary,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
          ),
        ),
      );
    });
  }

  Widget _buildRegisterNowWidget(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(
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

  Widget _buildGoogleLoginButton(BuildContext context) {
    return SizedBox(
      width: context.width * 0.55,
      height: context.height * 0.06,
      child: buildGoogleSignInButton(
          onPressed: controller.loginWithGoogle, isDark: AppUtils.isDarkMode(),),
    );
  }
}
