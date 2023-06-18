import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_color_scheme.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/assets.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/utils/app_utils.dart';
import '../../../../../core/utils/are_equals_validation.dart';
import '../../../../../core/widgets/text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OptimizedScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  AppAssets.registerAnimation,
                  width: double.infinity,
                  height: context.height * .28,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppTrans.registerText.tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: colorScheme.onBackground,
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
                    label: AppTrans.emailLabel.tr,
                    hint: AppTrans.emailHint.tr,
                    controller: controller.emailController,
                    type: TextInputType.emailAddress,
                    validator: qValidator([
                      IsRequired(AppTrans.emailRequired.tr),
                      IsEmail(AppTrans.notEmailError.tr),
                    ]),
                    prefix: Icon(
                      Icons.email,
                      color: colorScheme.secondary,
                    ),
                    shouldAutoValidate: true,
                    onValidationChanged: (isValid) {
                      controller.isEmailValid.value = isValid;
                    },
                    textInputAction: TextInputAction.next,
                    focus: controller.emailFocus,
                    nextFocus: controller.passwordFocus,
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
                        onPressed: controller.changeHidePasswordState,
                        color: colorScheme.secondary,
                      ),
                      validator: qValidator([
                        IsRequired(
                          AppTrans.passwordRequired.tr,
                        ),
                        MinLength(
                          6,
                          AppTrans.passwordMinLengthError.tr,
                        )
                      ]),
                      prefix: Icon(
                        Icons.lock,
                        color: colorScheme.secondary,
                      ),
                      onChanged: (text) {
                        if (controller
                            .confirmPasswordController.value.text.isNotEmpty) {
                          AppUtils.validate(
                            controller.confirmPasswordFormKey,
                            controller.isConfirmPasswordValid,
                          );
                        }
                      },
                      shouldAutoValidate: true,
                      onValidationChanged: (isValid) {
                        controller.isPasswordValid.value = isValid;
                      },
                      textInputAction: TextInputAction.next,
                      focus: controller.passwordFocus,
                      nextFocus: controller.confirmPasswordFocus,
                    ),
                  );
                }),
                Obx(() {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    child: CustomTextField(
                      label: AppTrans.confirmPasswordLabel.tr,
                      hint: AppTrans.confirmPasswordHint.tr,
                      controller: controller.confirmPasswordController,
                      obscureText: controller.hideConfirmPassword.value,
                      type: TextInputType.visiblePassword,
                      suffix: IconButton(
                        icon: Icon(
                          controller.hideConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.changeHideConfirmPasswordState,
                        color: colorScheme.secondary,
                      ),
                      validator: qValidator([
                        IsRequired(
                          AppTrans.passwordRequired.tr,
                        ),
                        AreEqual(
                          other: () => controller.passwordController.value.text,
                          errorMsg: AppTrans.confirmPasswordMatchError.tr,
                        ),
                      ]),
                      prefix: Icon(
                        Icons.lock,
                        color: colorScheme.secondary,
                      ),
                      shouldAutoValidate: true,
                      onValidationChanged: (isValid) {
                        controller.isConfirmPasswordValid.value = isValid;
                      },
                      focus: controller.confirmPasswordFocus,
                    ),
                  );
                }),
                Obx(() {
                  return Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 10,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          colorScheme.secondary,
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
                      onPressed: controller.register,
                      child: SizedBox(
                        width: context.width * 0.5,
                        height: context.height * 0.05,
                        child: controller.isLoading.value
                            ? CenterLoading(
                                color: colorScheme.onSecondary,
                              )
                            : Center(
                                child: Text(
                                  AppTrans.registerText.tr,
                                  style: TextStyle(
                                    color: colorScheme.onSecondary,
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
                    onTap: controller.navigateToLogin,
                    child: RichText(
                      text: TextSpan(
                        text: AppTrans.haveAccountText.tr,
                        style: TextStyle(
                          color: colorScheme.onBackground,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppTrans.loginNow.tr,
                            style: TextStyle(
                              color: colorScheme.secondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: AppTrans.termsAndPrivacyInitialText.tr,
                      style: TextStyle(
                        color: colorScheme.onBackground,
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppTrans.terms.tr,
                          style: TextStyle(
                            color: colorScheme.secondary,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: AppTrans.andText.tr,
                          style: TextStyle(
                            color: colorScheme.onBackground,
                            fontSize: 12,
                          ),
                        ),
                        TextSpan(
                          text: AppTrans.privacyPolicyText.tr,
                          style: TextStyle(
                            color: colorScheme.secondary,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
