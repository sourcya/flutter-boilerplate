import 'package:flutter_boilerplate/app/routes/app_pages.dart';
import 'package:playx/playx.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    oneSecond().then((_) {
      // final service = Get.find<AuthService>();
      // if (service.isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
      // }
    });
    super.onInit();
  }
}
