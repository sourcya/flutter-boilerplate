part of '../imports/login_view_imports.dart';

///Getx binding to initialize login controller.
class OtpLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpLoginController>(
      () => OtpLoginController(),
    );
  }
}
