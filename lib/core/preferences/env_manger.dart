import 'package:playx/playx.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class EnvManger {
  static final EnvManger instance = getIt.isRegistered<EnvManger>()
      ? getIt.get<EnvManger>()
      : EnvManger();

  void init() {
    getIt.registerSingleton<EnvManger>(EnvManger());
  }

  final String _sentryKey = 'SENTRY_KEY';
  final String _showVersionCodeKey = 'SHOW_VERSION_CODE';
  Future<String> get sentryKey => PlayxEnv.getString(_sentryKey);

  Future<bool> get showVersionCode => PlayxEnv.getBool(_showVersionCodeKey);
}
