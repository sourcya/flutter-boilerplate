import 'dart:convert';

import 'package:flutter_boilerplate/app/app_launch/auth/data/models/models.dart';
import 'package:flutter_boilerplate/core/models/src/media_item.dart';
import 'package:flutter_boilerplate/core/network/src/helper/api_helper.dart';
import 'package:playx/playx.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class MyPreferenceManger {
  static final MyPreferenceManger instance = Get.find<MyPreferenceManger>();

  final String _tokenKey = 'token';
  final String _userKey = 'logged_in_user';
  final String _loginMethodKey = 'login_method';
  final String _onBoardingKey = 'onboarding_key';
  final String _userRoleTypeKey = 'user_role_type';

  Future<bool> get isLoggedIn async =>
      (await PlayxSecurePrefs.getString(_tokenKey)).isNotEmpty;

  Future<bool> get isLoggedOut async => !(await isLoggedIn);

  Future<LoginMethod?> get loginMethod async {
    final String? value =
        await PlayxSecurePrefs.maybeGetString(_loginMethodKey);
    return LoginMethod.fromValue(value);
  }

  Future<void> saveLoginMethod(LoginMethod method) async {
    await PlayxSecurePrefs.setString(_loginMethodKey, method.value);
  }

  Future<String?> get token async => PlayxSecurePrefs.maybeGetString(_tokenKey);

  Future<void> saveToken(String jwt) async {
    await PlayxSecurePrefs.setString(_tokenKey, jwt);
  }

  Future<UserRoleType?> get userRoleType async {
    final role = await PlayxSecurePrefs.maybeGetString(_userRoleTypeKey);
    return role == null ? null : UserRoleType.fromString(role);
  }

  Future<void> saveUserRoleType(UserRoleType? role) async {
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

  Future<bool> get isOnBoardingShown async =>
      PlayxPrefs.getBool(_onBoardingKey);

  Future<void> saveOnBoardingShown() async {
    return PlayxPrefs.setBool(_onBoardingKey, true);
  }
}
