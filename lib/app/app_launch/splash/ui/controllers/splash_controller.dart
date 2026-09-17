part of '../imports/splash_imports.dart';

class SplashController extends FullLifeCycleController with FullLifeCycleMixin {
  final Completer<bool> isAnimationCompleted = Completer();
  final Completer<bool> isAppSetupCompleted = Completer();
  final RxBool showVersionCode = false.obs;
  final RxBool showAppSetupCard = false.obs;

  bool logoAnimationPlayed = false;

  Timer? _animationTimer;

  @override
  void onInit() {
    super.onInit();
    unawaited(_runSplashBootstrap());
    updateAppVersion();
    checkAppVersionAndNavigateToNextPage();
  }

  Future<void> get appSetupFuture async {
    await Playx.asyncBootFuture();
  }

  Future<void> _runSplashBootstrap() async {
    final isAppSetupDone =
        kIsWeb || await MyPreferenceManger.instance.isAppSetupDone;

    _animationTimer?.cancel();
    _animationTimer = Timer(const Duration(seconds: 5), () {
      if (!isAnimationCompleted.isCompleted) {
        isAnimationCompleted.complete(true);
      }
    });

    if (isAppSetupDone) {
      showAppSetupCard.value = false;
      if (!isAppSetupCompleted.isCompleted) {
        isAppSetupCompleted.complete(true);
      }
    } else {
      await isAnimationCompleted.future;
      showAppSetupCard.value = true;
    }
  }

  Future<void> updateAppVersion() async {
    showVersionCode.value = await EnvManger.instance.showVersionCode;
  }

  Future<void> checkAppVersionAndNavigateToNextPage() async {
    await Playx.asyncBootFuture();
    if (PlayxNavigation.navigationContext?.isAppPortrait ?? true) {
      await isAnimationCompleted.future;
    }
    await isAppSetupCompleted.future;

    final isLandscape =
        PlayxNavigation.navigationContext?.isAppLandscape ?? false;
    final isOnBoardingShown =
        await MyPreferenceManger.instance.isOnBoardingShown;
    if (!isOnBoardingShown && !isLandscape) {
      AppNavigation.navigateFromSplashToOnBoarding();
      return;
    }

    final isUserLoggedIn = await ApiHelper.instance.isLoggedIn();
    if (!isUserLoggedIn) {
      AppNavigation.navigateFormSplashToLogin();
      return;
    }

    await AppController.instance.updateCurrentUser();

    final sessionStatus = await AppController.instance.checkSessionStatus();
    switch (sessionStatus) {
      case AppSessionStatus.active:
        break;
      case AppSessionStatus.sessionExpired:
        await SessionManager.instance.showSessionExpiredDialog();
        return;
    }

    AppNavigation.navigateFormSplashToHome();
  }

  void handleAnimationCompleted(AnimationController controller) {
    logoAnimationPlayed = true;
    if (!isAnimationCompleted.isCompleted) {
      isAnimationCompleted.complete(true);
    }
  }

  Future<void> handleOnContinueTap() async {
    await MyPreferenceManger.instance.saveAppSetupCompleted();
    if (!isAppSetupCompleted.isCompleted) {
      isAppSetupCompleted.complete(true);
    }
  }

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {}

  @override
  void onClose() {
    _animationTimer?.cancel();
    super.onClose();
  }
}
