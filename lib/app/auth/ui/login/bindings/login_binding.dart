import 'package:get/get.dart';

import '../controllers/login_controller.dart';

///Getx binding to initialize login controller.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
