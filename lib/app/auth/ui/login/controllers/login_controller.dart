import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/app/auth/data/repo/biometric_auth_repository.dart';
import 'package:playx/playx.dart';

import '../../../../../core/navigation/app_navigation.dart';
import '../../../../../core/network/models/exceptions/network_exception.dart';
import '../../../../../core/utils/alert.dart';
import '../../../data/models/api_user.dart';
import '../../../data/repo/auth_repository.dart';
import '../../../data/repo/google_auth_repository.dart';

///Login controller to setup data to the ui.
class LoginController extends GetxController {
  final authRepository = AuthRepository();
  final biometricAuthRepo = BiometricAuthRepository();
  final googleAuthRepo = GoogleAuthRepository();

  final AppNavigation appNavigation = AppNavigation.instance;
  final isLoading = false.obs;
  final hidePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;

  final isFormValid = false.obs;

  final isBiometricAuthEnabled = true;

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
      success: (ApiUser user) async {
        isLoading.value = false;
        authenticateWithBiometric();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  Future<void> authenticateWithBiometric() async {
    final isBiometricAvailable = await biometricAuthRepo.canAuthenticate();
    if (isBiometricAuthEnabled && isBiometricAvailable) {
      final bioAuthResult = await biometricAuthRepo.authenticate();

      bioAuthResult.when(
        success: (isAuthenticated) {
          if (isAuthenticated) {
            appNavigation.navigateFromLoginToHome();
          } else {
            Alert.message(message: 'couldn\'t authenticate');
          }
        },
        error: (message) {
          Alert.error(message: message);
        },
      );
    } else {
      appNavigation.navigateFromLoginToHome();
    }
  }

  Future<void> loginWithGoogle() async {
    final res = await googleAuthRepo.signIn();
    res.when(
      success: (user) {
        appNavigation.navigateFromLoginToHome();
        Alert.success(
            message: 'Logged in successfully using Google with ${user.email}');
      },
      error: (message) {
        Alert.error(message: message);
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
