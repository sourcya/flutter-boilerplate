class SettingsDatasource {
  static final SettingsDatasource _instance = SettingsDatasource._internal();

  factory SettingsDatasource() {
    return _instance;
  }

  SettingsDatasource._internal();
}
