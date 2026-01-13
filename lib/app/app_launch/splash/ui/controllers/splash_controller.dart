part of '../imports/splash_imports.dart';

class SplashController extends FullLifeCycleController with FullLifeCycleMixin {
  final isBiometricAuthEnabled = false;
  final Completer<bool> shouldUpdateApp = Completer();
  final Completer<bool> isAnimationCompleted = Completer();
  final RxBool showVersionCode = false.obs;

  @override
  void onInit() {
    // handleAppUpdate();
    super.onInit();
    updateAppVersion();
    _checkAnimationCompleted();
    checkAppVersionAndNavigateToNextPage();
  }

  void _checkAnimationCompleted() {
    Future.delayed(const Duration(seconds: 5), () {
      if (!isAnimationCompleted.isCompleted) {
        isAnimationCompleted.complete(true);
      }
    });
  }

  Future<void> updateAppVersion() async {
    showVersionCode.value = await EnvManger.instance.showVersionCode;
  }

  Future<void> checkAppVersionAndNavigateToNextPage({
    bool shouldCheckVersion = false,
  }) async {
    if (shouldCheckVersion) {
      final doesAppNeedUpdate = await shouldUpdateApp.future;
      if (doesAppNeedUpdate) return;
    }

    await Playx.asyncBootFuture();
    if (!kIsWeb) {
      await isAnimationCompleted.future;
    }
    final isLandscape = ScreenUtil().orientation == Orientation.landscape;
    final isOnBoardingShown =
        await MyPreferenceManger.instance.isOnBoardingShown;
    if (!isOnBoardingShown && !isLandscape) {
      AppNavigation.navigateFromSplashToOnBoarding();
      return;
    }

    final isUserLoggedIn =
        await ApiHelper.instance.isLoggedIn(checkAuth0: false);
    if (!isUserLoggedIn) {
      AppNavigation.navigateFormSplashToLogin();
      return;
    }
    AppNavigation.navigateFormSplashToHome();
  }

  Future<void> handleAppUpdate() async {
    // final result = await PlayxVersionUpdate.showUpdateDialog(
    //   context: PlayxNavigation.navigationContext!,
    //   forceUpdate: false,
    //   googlePlayId: Constants.playStoreId,
    //   country: Constants.storeCountry,
    //   language: Constants.storeLanguage,
    //   onCancel: (info) {
    //     if (info.forceUpdate) {
    //       exit(0);
    //     } else {
    //       checkAppVersionAndNavigateToNextPage(shouldCheckVersion: false);
    //     }
    //   },
    //   onUpdate: (info, mode) {
    //     PlayxVersionUpdate.openStore(
    //       storeUrl: Constants.storeUrl,
    //       launchMode: mode,
    //     );
    //     checkAppVersionAndNavigateToNextPage(shouldCheckVersion: false);
    //   },
    //   title: (info) => AppTrans.updateTitle.tr(),
    //   description: (info) => AppTrans.updateDescription.tr(),
    //   releaseNotesTitle: (info) => AppTrans.updateReleaseNotesTitle.tr(),
    //   updateActionTitle: AppTrans.updateConfirmActionTitle.tr(),
    //   dismissActionTitle: AppTrans.updateDismissActionTitle.tr(),
    // );
    // result.when(
    //   success: (canUpdate) {
    //     shouldUpdateApp.complete(canUpdate);
    //   },
    //   error: (error) {
    //     shouldUpdateApp.complete(false);
    //   },
    // );
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    // checkAppVersionAndNavigateToNextPage();
  }

  @override
  void onHidden() {}

  void handleAnimationCompleted(AnimationController controller) {
    if (!isAnimationCompleted.isCompleted) {
      isAnimationCompleted.complete(true);
    }
  }
}
