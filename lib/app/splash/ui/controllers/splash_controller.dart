import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    final bool isUserLoggedIn = MyPreferenceManger().isLoggedIn;

    twoSeconds().then((_) {
      isUserLoggedIn
          ? AppNavigation.instance.navigateFromSplashToHome()
          : AppNavigation.instance.navigateFormSplashToHome();
    });
    super.onInit();
  }
}
