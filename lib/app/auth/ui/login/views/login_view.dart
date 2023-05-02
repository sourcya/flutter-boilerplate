import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:playx/exports.dart';

import '../../../../../core/resources/assets.dart';
import '../../../../../core/resources/translation/app_translations.dart';
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
                Lottie.asset(
                  AppAssets.loginAnimation,
                  width: double.infinity,
                  height: context.height * .4,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppTrans.loginText.tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: context.colorScheme.onBackground,
                        fontSize: 40,
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: CustomTextField(
                    label: AppTrans.emailOrUsernameLabel.tr,
                    hint: AppTrans.emailHint.tr,
                    controller: controller.emailController,
                    type: TextInputType.emailAddress,
                    validator: qValidator([
                      IsRequired(AppTrans.emailRequired.tr),
                    ]),
                    prefix: Icon(
                      Icons.email,
                      color: context.colorScheme.secondary,
                    ),
                    shouldAutoValidate: true,
                    onValidationChanged: (isValid) {
                      controller.isEmailValid.value = isValid;
                    },
                  ),
                ),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: CustomTextField(
                      label: AppTrans.passwordLabel.tr,
                      hint: AppTrans.passwordHint.tr,
                      controller: controller.passwordController,
                      obscureText: controller.hidePassword.value,
                      type: TextInputType.visiblePassword,
                      suffix: IconButton(
                        icon: Icon(
                          controller.hidePassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          controller.hidePassword.value =
                              !controller.hidePassword.value;
                        },
                        color: context.colorScheme.secondary,
                      ),
                      validator: qValidator([
                        IsRequired(
                          AppTrans.passwordRequired.tr,
                        ),
                        MinLength(6, AppTrans.passwordMinLengthError.tr)
                      ]),
                      prefix: Icon(
                        Icons.lock,
                        color: context.colorScheme.secondary,
                      ),
                      shouldAutoValidate: true,
                      onValidationChanged: (isValid) {
                        controller.isPasswordValid.value = isValid;
                      },
                    ),
                  );
                }),
                Obx(() {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          context.colorScheme.secondary,
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ), // <-- Radius
                          ),
                        ),
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.all(8),
                        ),
                      ),
                      onPressed: controller.login,
                      child: SizedBox(
                        width: context.width * 0.5,
                        height: context.height * 0.05,
                        child: controller.isLoading.value
                            ? CenterLoading(
                                color: context.colorScheme.onSecondary,
                              )
                            : Center(
                                child: Text(
                                  AppTrans.loginText.tr,
                                  style: TextStyle(
                                    color: context.colorScheme.onSecondary,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: InkWell(
                    onTap: controller.navigateToRegister,
                    child: RichText(
                      text: TextSpan(
                        text: AppTrans.dontHaveAccountText.tr,
                        style: TextStyle(
                          color: context.colorScheme.onBackground,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppTrans.registerNow.tr,
                            style: TextStyle(
                              color: context.colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
