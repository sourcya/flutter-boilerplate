part of '../imports/verify_phone_view_imports.dart';

class VerifyPhoneBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyPhoneController>(
      () => VerifyPhoneController(),
    );
  }
}
