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

  final formKey = GlobalKey<FormState>();

  final authRepository = AuthRepository();
  final AppNavigation appNavigation = AppNavigation.instance;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> register() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) return;
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
      error: (NetworkExceptions exception) {
        Alert.error(message: NetworkExceptions.getErrorMessage(exception));
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
