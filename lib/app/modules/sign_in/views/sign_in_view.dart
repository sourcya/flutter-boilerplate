import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/modules/sign_in/controllers/sign_in_controller.dart';
import 'package:flutter_boilerplate/app/shared/widgets/center_loading.dart';
import 'package:flutter_boilerplate/app/shared/widgets/text_field.dart';
import 'package:playx/playx.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.formKey,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomTextField(
                            hint: 'User Name Or Email',
                            controller: controller.emailController,
                            validator: qValidator([
                              IsRequired(),
                            ]),
                          ),
                          Obx(() {
                            return CustomTextField(
                              hint: 'Password',
                              controller: controller.passwordController,
                              obscureText: controller.hidePassword.value,
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
                              ),
                              validator: qValidator([
                                IsRequired(),
                              ]),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                  Obx(() {
                    return ElevatedButton(
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
                      ),
                      onPressed: controller.signIn,
                      child: SizedBox(
                        width: context.width * 0.4,
                        height: context.height * 0.05,
                        child: controller.isLoading.value
                            ? const CenterLoading(
                                color: Colors.black,
                              )
                            : const Center(child: Text('Login')),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
