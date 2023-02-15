import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../../../core/resources/translation/app_translations.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(
              flex: 5,
            ),
            Center(
              child: Text(
                AppTrans.appName.tr,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 30,
                  horizontal: 10,
                ),
                alignment: Alignment.center,
                child: Text(
                  controller.versionName.value,
                  style: const TextStyle(fontSize: 13, color: Colors.yellow),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
