import 'dart:async';
import 'dart:io';

import 'package:playx/playx.dart';
import 'package:playx_version_update/playx_version_update.dart';

import '../../../../core/config/keys.dart';
import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/utils/alert.dart';
import '../../../auth/data/repo/biometric_auth_repository.dart';

class SplashController extends FullLifeCycleController with FullLifeCycleMixin {
  final biometricAuthRepo = BiometricAuthRepository();

  final isBiometricAuthEnabled = false;
  final Completer<bool> shouldUpdateApp = Completer();

  @override
  void onInit() {
    handleAppUpdate();
    super.onInit();
    checkAppVersionAndNavigateToNextPage();
  }

  Future<void> handleAppUpdate() async {
    final result = await PlayxVersionUpdate.showUpdateDialog(
      context: Get.context!,
      forceUpdate: false,
      googlePlayId: Keys.playStoreId,
      appStoreId: Keys.appleId,
      country: Keys.storeCountry,
      language: Keys.storeLanguage,
      onCancel: (info) {
        if (info.forceUpdate) {
          exit(0);
        } else {
          checkAppVersionAndNavigateToNextPage(shouldCheckVersion: false);
        }
      },
      onUpdate: (info, mode) {
        PlayxVersionUpdate.openStore(storeUrl: Keys.storeUrl, launchMode: mode);
        checkAppVersionAndNavigateToNextPage(shouldCheckVersion: false);
      },
      title: (info) => AppTrans.updateTitle.tr,
      description: (info) => AppTrans.updateDescription.tr,
      releaseNotesTitle: (info) => AppTrans.updateReleaseNotesTitle.tr,
      updateActionTitle: AppTrans.updateConfirmActionTitle.tr,
      dismissActionTitle: AppTrans.updateDismissActionTitle.tr,
    );
    result.when(
      success: (canUpdate) {
        shouldUpdateApp.complete(canUpdate);
      },
      error: (error) {
        shouldUpdateApp.complete(false);
      },
    );
  }

  Future<void> checkAppVersionAndNavigateToNextPage(
      {bool shouldCheckVersion = true}) async {
    if (shouldCheckVersion) {
      final doesAppNeedUpdate = await shouldUpdateApp.future;
      if (doesAppNeedUpdate) return;
    }
    final bool isUserLoggedIn = MyPreferenceManger().isLoggedIn;
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
              Alert.message(message: "couldn't authenticate");
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
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    checkAppVersionAndNavigateToNextPage();
  }
}
