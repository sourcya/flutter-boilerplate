import 'package:flutter_boilerplate/app/modules/select_language/controllers/select_language_controller.dart';
import 'package:get/get.dart';

class SelectLanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectLanguageController>(
      () => SelectLanguageController(),
    );
  }
}
