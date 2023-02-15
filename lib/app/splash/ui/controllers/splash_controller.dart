import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';

class SplashController extends GetxController {
  RxString versionName = 'V'.obs;

  @override
  Future<void> onInit() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    versionName.value = "V$version";

    final bool isUserLoggedIn = MyPreferenceManger().isLoggedIn;

    twoSeconds().then((_) {
      isUserLoggedIn
          ? AppNavigation.instance.navigateFromSplashToHome()
          : AppNavigation.instance.navigateFormSplashToLogin();
    });
    super.onInit();
  }
}
