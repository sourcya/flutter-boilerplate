import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:playx/playx.dart';

import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/network/models/network_exception.dart';
import '../../../../../core/utils/alert.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';

///Login controller to setup data to the ui.
class LoginController extends GetxController {
  final authRepository = AuthRepository();
  final AppNavigation appNavigation = AppNavigation.instance;

  final isLoading = false.obs;
  final hidePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;

  final isFormValid = false.obs;

  @override
  void onInit() {
    if (kDebugMode) {
      emailController.text = 'bbbb@mail.com';
      passwordController.text = '123456';
      isEmailValid.value = true;
      isPasswordValid.value = true;
      isFormValid.value = true;
    }
    super.onInit();
    listenToValidationState();
  }

  void listenToValidationState() {
    everAll([
      isEmailValid,
      isPasswordValid,
    ], (callback) {
      final isValid = isEmailValid.value && isPasswordValid.value;
      isFormValid.value = isValid;
    });
  }

  Future<void> login() async {
    if (!isFormValid()) return;
    isLoading.value = true;

    final result = await authRepository.login(
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (ApiUser user) {
        isLoading.value = false;
        appNavigation.navigateFromLoginToHome();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.getMessage());
      },
    );
  }

  void navigateToRegister() {
    appNavigation.navigateFromLoginToRegister();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
  }
}
