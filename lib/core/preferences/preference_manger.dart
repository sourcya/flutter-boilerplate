import 'dart:convert';

import 'package:playx/playx.dart';

import '../../app/app_launch/auth/data/models/user.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class MyPreferenceManger {
  static final MyPreferenceManger instance = Get.find<MyPreferenceManger>();

  final String _tokenKey = 'token';
  final String _userKey = 'logged_in_user';
  final String _onBoardingKey = 'onboarding_key';

  bool get isLoggedIn => PlayxPrefs.getString(_tokenKey).isNotEmpty;

  bool get isLoggedOut => !isLoggedIn;

  String? get token => PlayxPrefs.getString(_tokenKey);

  Future<void> saveToken(String jwt) async {
    await PlayxPrefs.setString(_tokenKey, jwt);
  }

  Future<void> saveUser(User user) async {
    final String userString = jsonEncode(user);
    await PlayxPrefs.setString(_userKey, userString);
  }

  Future<User?> getSavedUser() async {
    final String jsonString = PlayxPrefs.getString(_userKey);
    if (jsonString.isEmpty) {
      return null;
    }

    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final User user = User.fromJson(json);
    return user;
  }

  Future<void> signOut() async {
    await PlayxPrefs.remove(_userKey);
    return PlayxPrefs.remove(_tokenKey);
  }

  Future<bool> get isOnBoardingShown async =>
      PlayxPrefs.getBool(_onBoardingKey);

  Future<void> saveOnBoardingShown() async {
    return PlayxPrefs.setBool(_onBoardingKey, true);
  }
}
