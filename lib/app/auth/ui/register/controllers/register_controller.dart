import 'dart:async';

import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/network/models/network_exception.dart';
import '../../../../../core/utils/alert.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';

class RegisterController extends GetxController {
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final confirmPasswordFormKey = GlobalKey<FormState>();

  final isUsernameValid = false.obs;
  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;
  final isConfirmPasswordValid = false.obs;

  final isFormValid = false.obs;

  final authRepository = AuthRepository();
  final AppNavigation appNavigation = AppNavigation.instance;

  @override
  void onInit() {
    super.onInit();
    listenToValidationState();
  }

  void listenToValidationState() {
    everAll([
      isUsernameValid,
      isEmailValid,
      isPasswordValid,
      isConfirmPasswordValid,
    ], (callback) {
      final isValid = isUsernameValid.value &&
          isEmailValid.value &&
          isPasswordValid.value &&
          isConfirmPasswordValid.value;

      isFormValid.value = isValid;
    });
  }

  Future<void> register() async {
    if (!isFormValid.value) return;
    isLoading.value = true;

    final result = await authRepository.register(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (ApiUser user) {
        appNavigation.navigateFromRegisterToHome();
      },
      error: (NetworkException exception) {
        Alert.error(message: exception.getMessage());
      },
    );
    isLoading.value = false;
  }

  void changeHidePasswordState() {
    hidePassword.value = !hidePassword.value;
  }

  void changeHideConfirmPasswordState() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  void navigateToLogin() {
    appNavigation.navigateFromRegisterToLogin();
  }
}