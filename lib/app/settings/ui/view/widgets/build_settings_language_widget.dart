import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/translation/app_translations.dart';
import '../../controller/settings_controller.dart';
import 'settings_dialog.dart';
import 'settings_tile.dart';

Widget buildSettingsLanguageWidget(BuildContext context,
    SettingsController controller,) {
  return Obx(() {
    return buildSettingsTile(
      title: AppTrans.language.tr,
      subtitle: controller.currentLocale.value?.name ?? '',
      icon: Icons.language,
      onTap: () {
        Get.dialog(
          buildSettingsDialog(
            title: AppTrans.language.tr,
            items: controller.supportedLocales,
            onItemSelected: (lang) => controller.handleLanguageSelection(lang),
            itemName: (lang) => lang.name,
            itemIcon: null,
            isItemSelected: (lang) => controller.currentLocale.value == lang,
          ),
        );
      },);
  });
}
