part of '../../network.dart';

/// contains network endpoints.
abstract class Endpoints {
  static const baseUrl = "https://sourcya-connect.herokuapp.com";

  /// `POST`
  static const loginViaAuth0 = '/auth/auth0/callback';
  static const login = '/auth/local';
  static const register = '/auth/local/register';
  static const upload = '/upload';

  static const profile = '/users/me';
  static const updateUser = '/users/edit-profile';

  static const privacyPolicy = '/legal/privacy-policy';
  static const termsConditions = '/legal/terms-conditions';

  static const settings = '/settings';
  static const syncSettings = '/settings/sync';
  static const resetSettings = '/settings/reset';
}
