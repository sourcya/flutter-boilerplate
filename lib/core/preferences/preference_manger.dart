import 'dart:convert';

import 'package:playx/playx.dart';

import '../../app/auth/data/models/user.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class MyPreferenceManger {
  static final MyPreferenceManger instance = Get.find<MyPreferenceManger>();

  final String _tokenKey = 'token';
  final String _userKey = 'logged_in_user';
  final String _onBoardingKey = 'onboarding_key';


  bool get isLoggedIn => (Prefs.getString(_tokenKey) ?? '').isNotEmpty;

  bool get isLoggedOut => !isLoggedIn;

  String? get token => Prefs.getString(_tokenKey);

  Future<void> saveToken(String jwt) async {
    await Prefs.setString(_tokenKey, jwt);
  }

  Future<void> saveUser(User user) async {
    final String userString = jsonEncode(user);
    await Prefs.setString(_userKey, userString);
  }



  Future<User?> getSavedUser() async {
    final String? jsonString = Prefs.getString(_userKey);
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    } else {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final User user = User.fromJson(json);
      return user;
    }
  }

  Future<void> signOut() async {
    await Prefs.remove(_userKey);
    return Prefs.remove(_tokenKey);
  }


  Future<bool> get isOnBoardingShown async => Prefs.getBool(_onBoardingKey);

  Future<void> saveOnBoardingShown() async {
    return Prefs.setBool(_onBoardingKey, true);
  }

}
