import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:queen_validators/queen_validators.dart';

import '../../../../../core/resources/assets.dart';
import '../../../../../core/resources/colors.dart';
import '../../../../../core/resources/translation/app_translations.dart';
import '../../../../../core/widgets/center_loading.dart';
import '../../../../../core/widgets/text_field.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

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
                          label: AppTrans.emailOrUsernameLabel.tr,
                          hint: AppTrans.emailHint.tr,
                          controller: controller.emailController,
                          fillColor: AppColors.blue,
                          type: TextInputType.emailAddress,
                          validator: qValidator([
                            IsRequired(AppTrans.emailRequired.tr),
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
                              onPressed: () {
                                controller.hidePassword.value =
                                    !controller.hidePassword.value;
                              },
                              color: AppColors.pinkDark,
                            ),
                            validator: qValidator([
                              IsRequired(
                                AppTrans.passwordRequired.tr,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          margin: const EdgeInsets.symmetric(
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
                            onPressed: controller.login,
                            child: SizedBox(
                              width: context.width * 0.5,
                              height: context.height * 0.05,
                              child: controller.isLoading.value
                                  ? const CenterLoading(
                                      color: Colors.white,
                                    )
                                  : Center(
                                      child: Text(
                                        AppTrans.loginText.tr,
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
                          onTap: controller.navigateToRegister,
                          child: RichText(
                            text: TextSpan(
                              text: AppTrans.dontHaveAccountText.tr,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                              children: <TextSpan>[
                                TextSpan(
                                  text: AppTrans.registerNow.tr,
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const Spacer(
                        flex: 1,
                      )
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
