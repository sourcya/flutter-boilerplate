part of '../../network.dart';

/// contains network endpoints.
abstract class Endpoints {
  static const baseUrl =
      "https://sonbol-crm-service-545469892583.europe-west1.run.app/api";

  /// `POST`
  static const loginViaAuth0 = '/auth/auth0/callback';
  static const login = '/auth/local';
  static const register = '/auth/local/register';
  static const upload = '/upload';

  static const profile = '/users/me';
  static const updateUser = '/users/edit-profile';
}
