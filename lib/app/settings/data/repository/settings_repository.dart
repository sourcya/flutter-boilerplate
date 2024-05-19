class SettingsRepository {
  static final SettingsRepository _instance = SettingsRepository._internal();

  factory SettingsRepository() {
    return _instance;
  }

  SettingsRepository._internal();
}
