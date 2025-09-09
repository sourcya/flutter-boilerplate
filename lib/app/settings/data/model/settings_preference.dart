part of '../../ui/imports/settings_imports.dart';

enum SettingsSection {
  preferences,
  notifications,
  security,
  dataStorage,
  support,
  account
}

class SettingsPreference {
  final String id;
  final String title;
  final String? subtitle;
  final IconData icon;
  final SettingsSection section;
  final bool isToggleable;
  final bool isDangerous;
  final VoidCallback? onTap;

  const SettingsPreference({
    required this.id,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.section,
    this.isToggleable = false,
    this.isDangerous = false,
    this.onTap,
  });
}
