part of '../imports/splash_imports.dart';

class SplashController extends FullLifeCycleController with FullLifeCycleMixin {
  final isBiometricAuthEnabled = false;
  final Completer<bool> shouldUpdateApp = Completer();

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
      googlePlayId: Constants.playStoreId,
      appStoreId: Constants.appleId,
      country: Constants.storeCountry,
      language: Constants.storeLanguage,
      onCancel: (info) {
        if (info.forceUpdate) {
          exit(0);
        } else {
          checkAppVersionAndNavigateToNextPage(shouldCheckVersion: false);
        }
      },
      onUpdate: (info, mode) {
        PlayxVersionUpdate.openStore(
            storeUrl: Constants.storeUrl, launchMode: mode,);
        checkAppVersionAndNavigateToNextPage(shouldCheckVersion: false);
      },
      title: (info) => AppTrans.updateTitle.tr(),
      description: (info) => AppTrans.updateDescription.tr(),
      releaseNotesTitle: (info) => AppTrans.updateReleaseNotesTitle.tr(),
      updateActionTitle: AppTrans.updateConfirmActionTitle.tr(),
      dismissActionTitle: AppTrans.updateDismissActionTitle.tr(),
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
      {bool shouldCheckVersion = true,}) async {
    // if (shouldCheckVersion) {
    //   final doesAppNeedUpdate = await shouldUpdateApp.future;
    //   if (doesAppNeedUpdate) return;
    // }

    await Future.delayed(2.seconds);
    if (!(await MyPreferenceManger.instance.isOnBoardingShown)) {
      AppNavigation.navigateFromSplashToOnBoarding();
      return;
    }

    final bool isUserLoggedIn = MyPreferenceManger().isLoggedIn;
    if (isUserLoggedIn) {
      AppNavigation.navigateFormSplashToHome();
    } else {
      AppNavigation.navigateFormSplashToLogin();
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

  @override
  void onHidden() {}
}
