abstract class Endpoints {
  static const baseUrl = 'https://sourcya.com/';
  static const api = '$baseUrl/api';

  static const v1 = '$api/v1';

  /// `POST`
  static const login = '/auth/login';
  static const register = '/auth/register';
}
