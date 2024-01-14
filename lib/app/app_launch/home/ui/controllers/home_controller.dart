part of '../imports/home_imports.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late PlatformTabController  pageController;
  final currentIndex = 0.obs;
  final AppNavigation _navigation = AppNavigation.instance;


  @override
  Future<void> onInit() async {
    pageController = PlatformTabController();
    super.onInit();
  }

  Future<void> updatePage(int value) {
    // Fimber.d('update page :$value');
    if(value ==3) signOut();
    // pageController.animateTo(value, duration: 250.milliseconds, curve: Curves.linear);
    pageController.setIndex(Get.context!, value);
    currentIndex.value = value;
    return Future.delayed(100.milliseconds);
  }




  Future<bool> handleWillPop() async {
    bool isPopped = false;
    switch(currentIndex.value) {
      case 0 :
        isPopped = await _navigation.popFirstTab();
      case 1 :
        isPopped = await _navigation.popSecondTab();
      case 2 :
        isPopped = await _navigation.popThirdTab();
    }
    if(isPopped) return false;

    if(currentIndex.value != 0){
      // pageController.animateTo(0, duration: 250.milliseconds, curve: Curves.linear);
      pageController.setIndex(Get.context!, 0);

      currentIndex.value = 0;
      return false;
    }
    return true;
  }

  void resetNavigation() {
    // pageController.animateTo(0, duration: 250.milliseconds, curve: Curves.linear);
    pageController.setIndex(Get.context!, 0);
    currentIndex.value = 0;
  }

  Future<void> signOut() async {
    resetNavigation();
    await MyPreferenceManger.instance.signOut();
    AppNavigation.instance.navigateToLogin();
  }
}
