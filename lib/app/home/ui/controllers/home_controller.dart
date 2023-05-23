import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../auth/data/models/user.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabC;
  Rx<User?> user = Rx(null);
  AppNavigation appNavigation = AppNavigation.instance;

  MyPreferenceManger preferenceManger = MyPreferenceManger.instance;
  @override
  Future<void> onInit() async {
    tabC = TabController(length: 3, vsync: this);
    super.onInit();
    user.value = await getCachedUser();
  }

  void onTapTab(int value) {
    tabC.animateTo(value);
    update();
  }

  Future<User?> getCachedUser() {
    return preferenceManger.getSavedUser();
  }

  Future<void> signOut() async {
    await preferenceManger.signOut();
    appNavigation.navigateFormSplashToHome();
  }
}
