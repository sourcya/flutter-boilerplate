import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/config/theme.dart';
import 'package:flutter_boilerplate/core/widgets/app_version.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:playx/playx.dart';

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
                style: TextStyle(
                  fontSize: 30,
                  color: AppThemeConfig.getColorScheme(context).onBackground,
                ),
              ),
            ),
            const Spacer(
              flex: 4,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 10,
              ),
              alignment: Alignment.center,
              child: AppVersion(
                textStyle: TextStyle(
                  fontSize: 13,
                  color: AppThemeConfig.getColorScheme(context).secondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
