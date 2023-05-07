import 'package:fimber/fimber.dart';
import 'package:flutter_boilerplate/app/auth/data/repo/biometric_auth_repository.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../../core/utils/alert.dart';

class SplashController extends GetxController {
  final biometricAuthRepo = BiometricAuthRepository();

  final isBiometricAuthEnabled = false;

  @override
  void onInit() {
    final bool isUserLoggedIn = MyPreferenceManger().isLoggedIn;

    twoSeconds().then((_) async {
      if (isUserLoggedIn) {
        Fimber.d("Biometric isUserLoggedIn :$isUserLoggedIn");

        final isBiometricAvailable = await biometricAuthRepo.canAuthenticate();
        if (isBiometricAuthEnabled && isBiometricAvailable) {
          final bioAuthResult = await biometricAuthRepo.authenticate();

          bioAuthResult.when(
            success: (isAuthenticated) {
              if (isAuthenticated) {
                biometricAuthRepo.stopBiometricAuthentication();
                AppNavigation.instance.navigateFormSplashToHome();
              } else {
                Alert.message(message: 'couldn\'t authenticate');
                AppNavigation.instance.navigateFormSplashToLogin();
              }
            },
            error: (message) {
              Alert.error(message: message);
              AppNavigation.instance.navigateFormSplashToLogin();
            },
          );
        } else {
          AppNavigation.instance.navigateFormSplashToHome();
        }
      } else {
        AppNavigation.instance.navigateFormSplashToLogin();
      }
    });
    super.onInit();
  }
}
