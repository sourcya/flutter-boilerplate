import 'package:flutter_boilerplate/core/ui/ui.dart';

enum SettingsTabs {
  account,
  preferences,
  notifications,
  activeModules;

  static const List<SettingsTabs> visibleTabs = [
    SettingsTabs.account,
    SettingsTabs.preferences,
    SettingsTabs.notifications,
    SettingsTabs.activeModules,
  ];

  String get title => switch (this) {
        SettingsTabs.account => AppTrans.account,
        SettingsTabs.preferences => AppTrans.preferences,
        SettingsTabs.notifications => AppTrans.notifications,
        SettingsTabs.activeModules => AppTrans.activeModulesTitle,
      };

  String get icon => switch (this) {
        SettingsTabs.account => Assets.icons.badgeCheck,
        SettingsTabs.preferences => Assets.icons.palette,
        SettingsTabs.notifications => Assets.icons.bell,
        SettingsTabs.activeModules => Assets.icons.modules,
      };

  String get iconAsset => icon;
}
