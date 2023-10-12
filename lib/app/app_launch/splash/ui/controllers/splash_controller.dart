part of '../imports/splash_imports.dart';

class SplashController extends FullLifeCycleController with FullLifeCycleMixin {
  final biometricAuthRepo = BiometricAuthRepository();

  final isBiometricAuthEnabled = false;
  final Completer<bool> shouldUpdateApp = Completer();

  final _navigation = AppNavigation.instance;
  @override
  void onInit() {
    // handleAppUpdate();
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
    // if (shouldCheckVersion) {
    //   final doesAppNeedUpdate = await shouldUpdateApp.future;
    //   if (doesAppNeedUpdate) return;
    // }

    await Future.delayed(2.seconds);
    if (!(await MyPreferenceManger.instance.isOnBoardingShown)) {
      _navigation.navigateFromSplashToOnBoarding();
      return;
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
              _navigation.navigateFormSplashToHome();
            } else {
              Alert.message(message: "couldn't authenticate");
              _navigation.navigateFormSplashToLogin();
            }
          },
          error: (message) {
            Alert.error(message: message);
            _navigation.navigateFormSplashToLogin();
          },
        );
      } else {
        _navigation.navigateFormSplashToHome();
      }
    } else {
      _navigation.navigateFormSplashToLogin();
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
