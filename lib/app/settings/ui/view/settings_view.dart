import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../controller/settings_controller.dart';
import 'widgets/build_settings_language_widget.dart';
import 'widgets/build_settings_theme_widget.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: AppTrans.settings.tr),
      body: OptimizedScrollView(
        child: Column(
          children: [
            buildSettingsLanguageWidget(context, controller),
            buildSettingsThemeWidget(context, controller),
          ],
        ),
      ),
    );
  }
}
