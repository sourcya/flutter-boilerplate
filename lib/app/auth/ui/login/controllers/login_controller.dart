import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:playx/playx.dart';

import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/network/models/network_exception.dart';
import '../../../../../core/utils/alert.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final hidePassword = true.obs;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final authRepository = AuthRepository();
  final AppNavigation appNavigation = AppNavigation.instance;

  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    if (kDebugMode) {
      emailController.text = 'bbbb@mail.com';
      passwordController.text = '123456';
    }
    super.onInit();
  }

  Future<void> login() async {
    final formState = formKey.currentState;
    if (formState == null || !formState.validate()) return;
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
}
