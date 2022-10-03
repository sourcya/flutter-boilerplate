import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/routes/app_pages.dart';
import 'package:playx/playx.dart';

import '../../../services/auth.dart';

class SignInController extends GetxController {
  final isLoading = false.obs;
  final hidePassword = false.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final service = Get.find<AuthService>();
  final formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    if (kDebugMode) {
      emailController.text = 'user@app.com';
      passwordController.text = '123456';
    }
    super.onInit();
  }

  Future<void> signIn() async {
    try {
      if (!formKey.currentState!.validate()) return;
      isLoading.value = true;
      await service.login(
        email: emailController.text,
        password: passwordController.text,
      );
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(e.toString(), '');
    } finally {
      isLoading.value = false;
    }
  }
}
