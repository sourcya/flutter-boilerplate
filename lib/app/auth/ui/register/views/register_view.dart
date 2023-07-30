import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/assets/assets.dart';
import '../../../../../core/resources/colors/app_color_scheme.dart';
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
            padding:  EdgeInsets.symmetric(
              vertical: 10.h,
              horizontal: 10.w,
            ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  Assets.animations.registerAnimation,
                  width: double.infinity,
                  height: context.height * .28,
                ),
                Container(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 10.w,
                  ),
                  width: double.infinity,
                  child: Text(
                    AppTrans.registerText.tr,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: colorScheme.onBackground,
                        fontSize: 40.sp,
                      ),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 5.h,
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
                    padding:  EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 5.h,
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
                    margin:  EdgeInsets.symmetric(
                      vertical: 5.h,
                    ),
                    padding:  EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 10.h,
                    ),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(
                          colorScheme.secondary,
                        ),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12.r,
                            ), // <-- Radius
                          ),
                        ),
                        padding:  MaterialStatePropertyAll(
                          EdgeInsets.all(8.r),
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
                                    fontSize: 18.sp,
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
                }),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    vertical: 5.h,
                  ),
                  child: InkWell(
                    onTap: controller.navigateToLogin,
                    child: RichText(
                      text: TextSpan(
                        text: AppTrans.haveAccountText.tr,
                        style: TextStyle(
                          color: colorScheme.onBackground,
                          fontSize: 14.sp,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppTrans.loginNow.tr,
                            style: TextStyle(
                              color: colorScheme.secondary,
                              fontSize: 14.sp,

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 10.w,
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: AppTrans.termsAndPrivacyInitialText.tr,
                      style: TextStyle(
                        color: colorScheme.onBackground,
                        fontSize: 12.sp,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: AppTrans.terms.tr,
                          style: TextStyle(
                            color: colorScheme.secondary,
                            fontSize: 12.sp,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                          text: AppTrans.andText.tr,
                          style: TextStyle(
                            color: colorScheme.onBackground,
                            fontSize: 12.sp,
                          ),
                        ),
                        TextSpan(
                          text: AppTrans.privacyPolicyText.tr,
                          style: TextStyle(
                            color: colorScheme.secondary,
                            fontSize: 12.sp,
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
