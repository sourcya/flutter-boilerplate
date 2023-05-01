import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    final bool isUserLoggedIn = MyPreferenceManger().isLoggedIn;

    twoSeconds().then((_) {
      isUserLoggedIn
          ? AppNavigation.instance.navigateFormSplashToHome()
          : AppNavigation.instance.navigateFormSplashToHome();
    });
    super.onInit();
  }
}
