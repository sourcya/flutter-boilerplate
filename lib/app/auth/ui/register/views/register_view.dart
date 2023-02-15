import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/assets.dart';
import '../../../../../core/resources/colors.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/widgets/center_loading.dart';
import '../../../../../core/widgets/text_field.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Form(
              key: controller.formKey,
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
                            textStyle: const TextStyle(
                              color: AppColors.pink,
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
                          fillColor: AppColors.blue,
                          type: TextInputType.emailAddress,
                          validator: qValidator([
                            IsRequired(AppTrans.emailRequired.tr),
                            IsEmail(AppTrans.notEmailError.tr),
                          ]),
                          prefix: const Icon(
                            Icons.email,
                            color: AppColors.pink,
                          ),
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
                            fillColor: AppColors.blue,
                            type: TextInputType.visiblePassword,
                            suffix: IconButton(
                              icon: Icon(
                                controller.hidePassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: controller.changeHidePasswordState,
                              color: AppColors.pinkDark,
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
                            prefix: const Icon(
                              Icons.lock,
                              color: AppColors.pink,
                            ),
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
                            fillColor: AppColors.blue,
                            type: TextInputType.visiblePassword,
                            suffix: IconButton(
                              icon: Icon(
                                controller.hideConfirmPassword.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed:
                                  controller.changeHideConfirmPasswordState,
                              color: AppColors.pinkDark,
                            ),
                            validator: qValidator([
                              IsRequired(
                                AppTrans.passwordRequired.tr,
                              ),
                              Match(
                                controller.passwordController.text,
                                error: AppTrans.confirmPasswordMatchError.tr,
                              ),
                            ]),
                            prefix: const Icon(
                              Icons.lock,
                              color: AppColors.pink,
                            ),
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
                              backgroundColor: const MaterialStatePropertyAll(
                                AppColors.pinkLight,
                              ),
                              textStyle: const MaterialStatePropertyAll(
                                TextStyle(color: Colors.white),
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
                                  ? const CenterLoading(
                                      color: Colors.white,
                                    )
                                  : Center(
                                      child: Text(
                                        AppTrans.registerText.tr,
                                        style: const TextStyle(
                                          color: Colors.white,
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
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppTrans.loginNow.tr,
                                  style: const TextStyle(
                                    color: Colors.yellow,
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
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: AppTrans.terms.tr,
                                style: const TextStyle(
                                  color: Colors.yellow,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                              ),
                              TextSpan(
                                text: AppTrans.andText.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              TextSpan(
                                text: AppTrans.privacyPolicyText.tr,
                                style: const TextStyle(
                                  color: Colors.yellow,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
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
          ),
        ],
      ),
    );
  }
}
