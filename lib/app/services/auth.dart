import 'dart:convert';

import 'package:playx_core/playx_core.dart';
import '../config/endpoints.dart';
import '../helpers/http_client.dart';
import '../models/user.dart';

class AuthService {
  final HttpClient client;

  AuthService(this.client);

  bool get isLoggedIn => (Prefs.getString('token') ?? '').isNotEmpty;

  bool get isLoggedOut => !isLoggedIn;

  UserModel? get cachedUser {
    final user = (jsonDecode(Prefs.getString('auth.user') ?? '') ?? {})
        as Map<String, dynamic>;
    if (user.isEmpty) return null;
    return UserModel.fromMap(user);
  }

  UserModel get user => cachedUser ?? (throw 'user is not logged in !');

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await oneSecond();
    final res = await client.post(
      Endpoints.login,
      attachToken: false,
      body: {
        'identifier': email,
        'password': password,
      },
    );

    // save the token to shared preferences
    final String jwt = (res.data as Map)['jwt'] as String;
    await Prefs.setString('token', jwt);

    /// save the user to shared preferences
    final userData = (res.data as Map)['user'] as Map<String, dynamic>;

    final user = UserModel.fromMap(userData);

    await Prefs.setString('auth.user', jsonEncode(user.toMap()));
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    final res = await client.post(
      Endpoints.register,
      attachToken: false,
      body: {
        'username': email,
        'email': email,
        'password': password,
      },
    );

    throwIfNot(200, res);
    // save the token to shared preferences
    final String jwt = (res.data as Map)['jwt'] as String;
    await Prefs.setString('token', jwt);

    /// save the user to shared preferences
    final userData = (res.data as Map)['user'] as Map<String, dynamic>;

    final user = UserModel.fromMap(userData);

    await Prefs.setString('auth.user', jsonEncode(user.toMap()));
  }

  Future<void> signOut() async {
    /// strapi does not have a signout endpoint
    /// https://forum.strapi.io/t/does-strapi-has-a-logout-endpoint/14886
    await Prefs.remove('auth.user');
    await Prefs.remove('token');
  }
}
