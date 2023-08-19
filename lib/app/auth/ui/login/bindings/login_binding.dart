part of '../imports/login_imports.dart';

///Getx binding to initialize login controller.
class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
