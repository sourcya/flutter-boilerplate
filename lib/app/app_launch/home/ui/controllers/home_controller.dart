part of '../imports/home_imports.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  Future<void> signOut() async {
    await MyPreferenceManger.instance.signOut();
    AppNavigation.navigateToLogin();
  }
}
