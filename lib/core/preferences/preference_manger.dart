import 'dart:convert';

import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/app/settings/data/models/app_module.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:playx/playx.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class MyPreferenceManger {
  static final MyPreferenceManger instance = getIt.get<MyPreferenceManger>();

  final String _tokenKey = 'token';
  final String _userKey = 'logged_in_user';
  final String _loginMethodKey = 'login_method';
  final String _onBoardingKey = 'onboarding_key';
  final String _appSetupDoneKey = 'app_setup_done_key';
  final String _userRoleTypeKey = 'user_role_type';
  final String _rememberMeKey = 'remember_me';
  final String _savedUsernameKey = 'saved_username';
  final String _savedPasswordKey = 'saved_password';
  final String _notificationsEnabledKey = 'notifications_enabled';
  final String _soundAlertsEnabledKey = 'sound_alerts_enabled';
  final String _activeModulesKey = 'active_modules';

  Future<bool> get isLoggedIn async => (await PlayxSecurePrefs.getString(_tokenKey)).isNotEmpty;

  Future<bool> get isLoggedOut async => !(await isLoggedIn);

  Future<LoginMethod?> get loginMethod async {
    final String? value = await PlayxSecurePrefs.maybeGetString(_loginMethodKey);
    return LoginMethod.fromValue(value);
  }

  Future<void> saveLoginMethod(LoginMethod method) async {
    await PlayxSecurePrefs.setString(_loginMethodKey, method.value);
  }

  Future<String?> get token => PlayxSecurePrefs.maybeGetString(_tokenKey);

  Future<void> saveToken(String jwt) async {
    await PlayxSecurePrefs.setString(_tokenKey, jwt);
  }

  Future<UserRoleType?> get userRoleType async {
    final role = await PlayxSecurePrefs.maybeGetString(_userRoleTypeKey);
    return role == null ? null : UserRoleType.fromString(role);
  }

  Future<void> saveUserRoleType(UserRoleType? role) {
    final value = role?.value;
    if (value == null) {
      return PlayxSecurePrefs.remove(_userRoleTypeKey);
    }
    return PlayxSecurePrefs.setString(_userRoleTypeKey, value);
  }

  Future<void> saveUser(ApiUserInfo user) async {
    final savedUser = await getSavedUser();
    final updatedUser = user.copyWith(image: savedUser?.image);
    final String userString = jsonEncode(updatedUser);
    return PlayxSecurePrefs.setString(_userKey, userString);
  }

  Future<UserInfo?> getSavedUser() async {
    final String jsonString = await PlayxSecurePrefs.getString(_userKey);
    if (jsonString.isEmpty) {
      return null;
    }
    final image = await ApiHelper.instance.profileImageUrl;

    return jsonString.mapAsync(
      mapper: (e) {
        final json = jsonDecode(e) as Map<String, dynamic>;
        final ApiUserInfo user = ApiUserInfo.fromJson(
          json,
          image: image?.isNotEmpty == true ? MediaItem(url: image) : null,
        );
        return user.toUserInfo();
      },
    );
  }

  Future<void> signOut() async {
    await PlayxSecurePrefs.remove(_userKey);
    return PlayxSecurePrefs.remove(_tokenKey);
  }

  Future<bool> get isOnBoardingShown async => PlayxPrefs.getBool(_onBoardingKey);

  Future<void> saveOnBoardingShown() => PlayxPrefs.setBool(_onBoardingKey, true);

  Future<bool> get isAppSetupDone async => PlayxPrefs.getBool(_appSetupDoneKey);

  Future<void> saveAppSetupCompleted() => PlayxPrefs.setBool(_appSetupDoneKey, true);

  Future<bool> get shouldRememberUser async => PlayxPrefs.getBool(_rememberMeKey);

  Future<void> saveRememberMe(bool value) => PlayxPrefs.setBool(_rememberMeKey, value);

  Future<String?> getSavedUsername() => PlayxSecurePrefs.maybeGetString(_savedUsernameKey);

  Future<String?> getSavedPassword() => PlayxSecurePrefs.maybeGetString(_savedPasswordKey);

  Future<void> saveUserCredentials({
    required String username,
    required String password,
  }) async {
    await PlayxSecurePrefs.setString(_savedUsernameKey, username);
    await PlayxSecurePrefs.setString(_savedPasswordKey, password);
  }

  Future<void> forgetUsernameAndPassword() async {
    await PlayxSecurePrefs.remove(_savedUsernameKey);
    await PlayxSecurePrefs.remove(_savedPasswordKey);
  }

  Future<bool> isNotificationsEnabled() async =>
      PlayxPrefs.getBool(_notificationsEnabledKey, fallback: true);

  Future<void> saveNotificationsEnabled(bool value) =>
      PlayxPrefs.setBool(_notificationsEnabledKey, value);

  Future<bool> isSoundAlertsEnabled() async =>
      PlayxPrefs.getBool(_soundAlertsEnabledKey, fallback: true);

  Future<void> saveSoundAlertsEnabled(bool value) =>
      PlayxPrefs.setBool(_soundAlertsEnabledKey, value);

  Future<List<String>> getActiveModuleTypes() async {
    final raw = PlayxPrefs.maybeGetString(_activeModulesKey);
    if (raw == null) {
      return AppModules.getInitialActiveAppModules().map((module) => module.type).toList();
    }
    if (raw.isEmpty) return const [];
    return raw.split(',').where((type) => type.isNotEmpty).toList();
  }

  Future<void> saveActiveModuleTypes(List<String> types) async {
    if (types.isEmpty) {
      await PlayxPrefs.setString(_activeModulesKey, '');
      return;
    }
    await PlayxPrefs.setString(_activeModulesKey, types.join(','));
  }

  Future<List<AppModule>> getActiveAppModules() async {
    final types = await getActiveModuleTypes();
    final modules = <AppModule>[];
    for (final type in types) {
      final module = AppModules.findByType(type);
      if (module != null && !modules.any((item) => item.type == module.type)) {
        modules.add(module);
      }
    }
    return modules;
  }

  Future<void> saveActiveAppModules(List<AppModule> modules) {
    final types = <String>[];
    for (final module in modules) {
      if (!types.contains(module.type)) {
        types.add(module.type);
      }
    }
    return saveActiveModuleTypes(types);
  }
}
