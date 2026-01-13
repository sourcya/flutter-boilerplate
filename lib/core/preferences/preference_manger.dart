import 'dart:convert';

import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:flutter_boilerplate/core/preferences/secure_storage_manager.dart';
import 'package:playx/playx.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class MyPreferenceManger {
  static final MyPreferenceManger instance =
      getIt.isRegistered<MyPreferenceManger>()
      ? getIt.get<MyPreferenceManger>()
      : MyPreferenceManger();

  void registerInstance() {
    getIt.registerSingleton<MyPreferenceManger>(MyPreferenceManger());
  }

  final String _tokenKey = 'token';
  final String _userKey = 'logged_in_user';
  final String _loginMethodKey = 'login_method';
  final String _onBoardingKey = 'onboarding_key';
  final String _userRoleTypeKey = 'user_role_type';

  /// Due to an issue with the secure storage plugin, we need to catch the
  /// exception and clear the storage if a BadPaddingException is thrown.
  /// https://github.com/mogol/flutter_secure_storage/issues/210
  Future<String?> _getSecureString(String key) async {
    try {
      final value = await SecureStorageManager.instance.getSecureString(key);
      return value;
    } on Exception {
      return null;
    }
  }

  Future<void> _setSecureString(String key, String value) {
    return SecureStorageManager.instance.setSecureString(key, value);
  }

  Future<void> _removeSecureString(String key) {
    return SecureStorageManager.instance.remove(key);
  }

  Future<bool> get isLoggedIn async =>
      (await _getSecureString(_tokenKey) ?? '').isNotEmpty;

  Future<bool> get isLoggedOut async => !(await isLoggedIn);

  Future<LoginMethod?> get loginMethod async {
    final String? value = await _getSecureString(_loginMethodKey);
    return LoginMethod.fromValue(value);
  }

  Future<void> saveLoginMethod(LoginMethod method) async {
    await _setSecureString(_loginMethodKey, method.value);
  }

  Future<String?> get token => _getSecureString(_tokenKey);

  Future<void> saveToken(String jwt) async {
    await _setSecureString(_tokenKey, jwt);
  }

  Future<UserRoleType?> get userRoleType async {
    final role = await _getSecureString(_userRoleTypeKey);
    return role == null ? null : UserRoleType.fromString(role);
  }

  Future<void> saveUserRoleType(UserRoleType? role) {
    final value = role?.value;
    if (value == null) {
      return _removeSecureString(_userRoleTypeKey);
    }
    return _setSecureString(_userRoleTypeKey, value);
  }

  Future<void> saveUser(ApiUserInfo user) async {
    final savedUser = await getSavedUser();
    final updatedUser = user.copyWith(image: savedUser?.image);
    final String userString = jsonEncode(updatedUser);
    return _setSecureString(_userKey, userString);
  }

  Future<UserInfo?> getSavedUser() async {
    final String jsonString = await _getSecureString(_userKey) ?? '';
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
    await _removeSecureString(_userKey);
    return _removeSecureString(_tokenKey);
  }

  Future<bool> get isOnBoardingShown async =>
      PlayxPrefs.getBool(_onBoardingKey);

  Future<void> saveOnBoardingShown() async {
    return PlayxPrefs.setBool(_onBoardingKey, true);
  }
}
