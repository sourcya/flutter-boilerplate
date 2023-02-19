import 'dart:convert';

import 'package:playx/playx.dart';

import '../../app/auth/data/models/user.dart';
import '../resources/translation/app_locale.dart';

class MyPreferenceManger {
  static final MyPreferenceManger instance = Get.find<MyPreferenceManger>();

  final String selectedLanguageKey = "selected_language";
  final String tokenKey = 'token';
  final String userKey = 'logged_in_user';

  String getAppSelectedLanguage() {
    return Prefs.getString(selectedLanguageKey) ?? AppLocale.englishLanguage;
  }

  bool get isLoggedIn => (Prefs.getString(tokenKey) ?? '').isNotEmpty;

  bool get isLoggedOut => !isLoggedIn;

  String? get token => Prefs.getString(tokenKey);

  Future<void> saveToken(String jwt) async {
    await Prefs.setString(tokenKey, jwt);
  }

  Future<void> saveUser(User user) async {
    final String userString = jsonEncode(user);
    await Prefs.setString(userKey, userString);
  }

  Future<User?> getSavedUser() async {
    final String? jsonString = Prefs.getString(userKey);
    if (jsonString == null || jsonString.isEmpty) {
      return null;
    } else {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      final User user = User.fromJson(json);
      return user;
    }
  }

  Future<void> signOut() async {
    await Prefs.remove(userKey);
    await Prefs.remove(tokenKey);
  }
}
