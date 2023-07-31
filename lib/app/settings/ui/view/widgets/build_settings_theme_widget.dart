import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../core/resources/translation/app_translations.dart';
import '../../controller/settings_controller.dart';
import 'settings_dialog.dart';
import 'settings_tile.dart';


Widget buildSettingsThemeWidget(BuildContext context,
    SettingsController controller,) {
  return Obx(() {
    return buildSettingsTile(
      title: AppTrans.theme.tr,
      subtitle: controller.currentTheme.value.name,
      icon: Icons.dark_mode_rounded,
      onTap: () {
        Get.dialog(
          buildSettingsDialog(
            title: AppTrans.theme.tr,
            items: AppTheme.supportedThemes,
            onItemSelected: (theme) => controller.handleThemeSelection(theme),
            itemName: (theme) => theme.name,
            itemIcon: null,
            isItemSelected: (theme) =>
            controller.currentTheme.value.id == theme.id,
          ),
        );
      },);
  });
}
